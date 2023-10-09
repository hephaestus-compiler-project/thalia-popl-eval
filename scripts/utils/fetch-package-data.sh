#! /bin/bash
#
# Kotlin Dependencies: xmlstarlet, gradle

# Multi-line string
pom_template="<project>
<modelVersion>4.0.0</modelVersion>
<groupId>my.group</groupId>
<artifactId>my-artifact</artifactId>
<version>0.0.1</version>
<dependencies>
<dependency>
  <groupId>#GROUPID</groupId>
    <artifactId>#ARTIFACTID</artifactId>
      <version>#VERSION</version>
  </dependency>
</dependencies>
</project>"

kotlin_build_1='''
import java.net.URL;
plugins {
    kotlin("jvm") version "1.7.20"
    id("org.jetbrains.dokka") version ("1.7.0")
}

repositories {
    mavenCentral()
}

dependencies {
'''

kotlin_build_2='''
}

sourceSets {
    getByName("main").kotlin {

'''

kotlin_build_3='''
    }
}

tasks.dokkaHtml.configure {
    dokkaSourceSets {
        configureEach {
            skipDeprecated.set(true)
            documentedVisibilities.set(
                setOf(
                    org.jetbrains.dokka.DokkaConfiguration.Visibility.PUBLIC,
                    org.jetbrains.dokka.DokkaConfiguration.Visibility.PROTECTED
                )
            )
        }
    }
}
'''

maven_central="https://repo1.maven.org/maven2"
minimum_javadoc_size=2000
minimum_sources_size=5000

fetch_packages()
{
	while IFS=',' read -r groupid artifactid version; do
        if "$option_k"; then
          version=$(echo "$version" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/[^[:alnum:].].*//')
        fi
        path=${groupid//./\/}
        groupname=${groupid//./\-}
        javadoc_file="${artifactid}-${version}-javadoc.jar"
        sources_file="${artifactid}-${version}-sources.jar"
        pom_file="${artifactid}-${version}.pom"
        url="$maven_central/$path/$artifactid/$version/$javadoc_file"
        url_sources="$maven_central/$path/$artifactid/$version/$sources_file"
        pom_url="${maven_central}/${path}/${artifactid}/${version}/${pom_file}"
        rootdir="$output/$groupname-$artifactid"

        if [ -d "$rootdir" ]; then
          continue
        fi

        echo "Processing $groupid $artifactid $version"
        mkdir -p $rootdir/html-docs

        # Create pom.xml
        echo "$pom_template" |
        sed "s/#VERSION/$version/g; s/#ARTIFACTID/$artifactid/g; s/#GROUPID/$groupid/g" > $rootdir/pom.xml

        # Fetch pom.xml
        wget -q -O $rootdir/dependency.xml "$pom_url"
        if [ $? -ne 0 ]; then
          rm -rf $rootdir
          continue
        fi

        # Hande kotlin project
        if $option_k; then
            # Download the sources
            mkdir -p $rootdir/sources
            wget -q -P $rootdir/sources  "$url_sources"
            if [ $? -ne 0 ]; then
              rm -r $rootdir
              continue
            fi

            file_size=$(stat -c %s "$rootdir/sources/$sources_file")
            if [ $file_size -lt $minimum_sources_size ]; then
              rm -rf $rootdir
              continue
            fi
            unzip -q $rootdir/sources/$sources_file -d $rootdir/sources
            # Extract dependencies
            dependencies=$(xmlstarlet sel -N ns="http://maven.apache.org/POM/4.0.0" -t -m "//ns:dependencies/ns:dependency" -v "concat(ns:groupId, ':', ns:artifactId, ':', ns:version)" -n "$rootdir/dependency.xml")
            # Run gradle setup
            cd $rootdir/sources/
            # Write settings file
            echo 'rootProject.name = "'${artifactid}'"' > settings.gradle.kts
            gradle wrapper
            # Find source directories
            srcs=$(find . -mindepth 1 -type f -name "*.kt" -exec dirname {} \; | awk -F'/' '{print $2}' | sort -u)
            # Synthesize build script
            echo "$kotlin_build_1" > build.gradle.kts
            for d in $dependencies; do
                echo '    implementation("'${d}'")' >> build.gradle.kts
            done
            echo "$kotlin_build_2" >> build.gradle.kts
            for s in $srcs; do
                echo '    srcDir("'${s}'")' >> build.gradle.kts
            done
            echo "$kotlin_build_3" >> build.gradle.kts
            # Generate the documentation
            ./gradlew dokkaHtml
            #
            cd -
            # Copy docs to html-docs
            rm -rf html-docs
            cp -r $rootdir/sources/build/dokka/html/ $rootdir/html-docs
            # Means dokka failed
            if [ $? -ne 0 ]; then
              rm -r $rootdir
              continue
            fi
            rm -rf $rootdir/sources
        else
            # Fetch javadoc
            wget -q -P $rootdir/html-docs  "$url"
            if [ $? -ne 0 ]; then
              rm -r $rootdir
              continue
            fi

            file_size=$(stat -c %s "$rootdir/html-docs/$javadoc_file")
            if [ $file_size -lt $minimum_javadoc_size ]; then
              rm -rf $rootdir
              continue
            fi
            unzip -q $rootdir/html-docs/$javadoc_file -d $rootdir/html-docs
        fi
	done
}


# Default values
input=""
output=""
option_k=false

# Parse command-line options and arguments
while getopts ":i:o:k" opt; do
	case $opt in
		i)
      input=$OPTARG
      ;;
		o)
      output=$OPTARG
      ;;
    k)
      option_k=true
      ;;
		:)
      echo "Error: Option -$OPTARG requires an argument."
      exit 1
      ;;
		\?)
      echo "Error: Invalid option -$OPTARG"
      exit 1
      ;;
	esac
done


# Check if input or output options are missing
if [ -z "$input" ] && [ -z "$output" ]; then
  echo "Error: Missing input and output options."
  echo "Usage: ./fetch-package-data.sh -i csv_file -o output_dir"
  exit 1
elif [ -z "$input" ]; then
  echo "Error: Missing input option."
  echo "Usage: ./fetch-package-data.sh -i csv_file -o output_dir"
  exit 1
elif [ -z "$output" ]; then
  echo "Error: Missing output option."
  echo "Usage: ./fetch-package-data.sh -i csv_file -o output_dir"
  exit 1
fi

mkdir -p $output
# Process the CSV based on the provided input and output options
if [ "$input" = "-" ]; then
  # Read from stdin
  fetch_packages
else
  # Read from file
  if [ -f "$input" ]; then
    fetch_packages < "$input"
  else
    echo "Error: File '$input' does not exist."
    exit 1
  fi
fi
