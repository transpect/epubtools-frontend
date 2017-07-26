# epubtools-frontend
Converts EPUB 2 and 3 (fixed/reflowable) from XHTML

This project provides a convenient frontend to convert EPUBs with the transpect epubtools library.
The epubtools library takes an XHTML file as input and generates an EPUB. Referenced resources such as CSS, 
JavaScript and images are automatically stored in the EPUB file. Layout, format and other parameters are 
configured in an XML file. 

## Download

You can either download this repository as Zip file or use Git or SVN.

### Clone with Git
```
$ git clone git@github.com:transpect/epubtools-frontend.git --recursive
```
### Checkout with SVN

```
$ svn co https://github.com/transpect/epubtools-frontend/trunk
```

## Invocation

### MacOS/Linux

You can choose whether to invoke epubtools XProc pipeline with an Bash script or XML Calabash. 

#### Bash script

```
./epubconvert [options ...] myInputFile.html
```

Option  | Description
------  | -------------
 -o     | path to custom output directory
 -c     | path to custom configuration file
 -d     | debug mode

#### XML Calabash

```
 ./calabash/calabash.sh \
    -i source=myInputFile.html \
    -i meta=myConfiguration.xml \
    $DIR/xpl/epubtools-frontend.xpl
```

### Windows

```
 ./calabash/calabash.bat \
    -i source=myInputFile.html \
    -i meta=myConfiguration.xml \
    $DIR/xpl/epubtools-frontend.xpl
```

## Configuration

Here is an example for a basic configuration. If you open the oXygen project file, the file is 
automatically validated (RelaxNG and Schematron). You can also find a commented version of this
file [here](https://github.com/transpect/epubtools/blob/13f250dd3dac3de7b72416cace4d14d56d255b1a/sample/epub-config.xml)

Major parameters are configured with the `epub-config` attributes:

Location                                          | Description
----------------------------------------------    | -------------
 `epub-config/@format`                            | EPUB2 \| EPUB3 \| KF8
 `epub-config/@layout`                            | reflowable \| fixed
 `epub-config/@css-handling`                      | regenerated-per-split\|regenerated-per-split remove-comments\|unchanged (default: regenerated-per-split)
 `epub-config/@html-subdir-name`                  | name of html subdirectory
 `epub-config/@indent`                            | true|false|selective (If indent="selective", p:store will store non-indented, and the indent before paragraphs etc)
 
 The element `metadata` includes additional metadata information which is later stored in the OPF file.
 
 The `hierarchy` element is used to configure how the HTML is split into chunks.

```xml
<?xml version="1.0" encoding="UTF-8"?>   
<?xml-model href="http://transpect.io/epubtools/schema/metadata-conf/metadata-conf.rng" schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="http://transpect.io/epubtools/schema/metadata-conf/metadata-conf.rng" schematypens="http://purl.oclc.org/dsdl/schematron"?>
<epub-config xmlns:tr="http://transpect.io" 
  format="EPUB3" 
  layout="reflowable" 
  css-handling="regenerated-per-split"
  html-subdir-name="text" 
  indent="selective">
	
  <cover href="images/cover.png" svg="true"/>
	
  <metadata xmlns:dc="http://purl.org/dc/elements/1.1/">
    <dc:identifier format="EPUB3">89392383923</dc:identifier>
    <dc:identifier format="KF8">89392383923</dc:identifier>
    <dc:title>Mustertitel</dc:title>
    <dc:creator>Autoren</dc:creator>
    <dc:publisher>Verlag</dc:publisher>
  	<dc:language>de</dc:language>
  </metadata>

  <hierarchy media-type="application/xhtml+xml" max-population="40" max-text-length="200000" generated-frontmatter-title="">
    <unconditional-split elt="div" attr="class" attval="white"/>
    <unconditional-split elt="h1"/>
    <heading elt="h1"/>
    <unconditional-split attr="epub:type" attval="cover"/>
  </hierarchy>
  
</epub-config>
```
