<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step" 
  xmlns:epub="http://transpect.io/epubtools" 
  version="1.0" 
  name="epubtools-frontend"
  type="epub:epubtools-frontend">
  
  <p:input port="source" primary="true"/>
  <p:input port="meta" primary="false"/>
  
  <p:option name="debug" select="'no'"/>
  <p:option name="debug-dir-uri" select="'debug'"/>
  <p:option name="status-dir-uri" select="'status'"/>
  <p:option name="terminate-on-error" select="'yes'"/>
  
  <p:import href="http://transpect.io/epubtools/xpl/epub-convert.xpl"/>
  
  <epub:convert>
    <p:input port="meta">
      <p:pipe port="meta" step="epubtools-frontend"/>
    </p:input>
    <p:input port="conf">
      <p:empty/>
    </p:input>
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="debug-dir-uri" select="$debug-dir-uri"/>
    <p:with-option name="status-dir-uri" select="$status-dir-uri"/>
    <p:with-option name="terminate-on-error" select="$terminate-on-error"/>
  </epub:convert>
  
  <p:sink/>
  
</p:declare-step>