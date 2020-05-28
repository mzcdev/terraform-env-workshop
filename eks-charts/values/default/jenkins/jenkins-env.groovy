#!/usr/bin/groovy
import groovy.transform.Field
@Field
def role = "devops"
@Field
def cluster = "eks-demo"
@Field
def base_domain = "demo.mzdev.be"
@Field
def slack_token = ""
@Field
def jenkins = "jenkins.closed.mzdev.be"
@Field
def harbor = "harbor-core.closed.mzdev.be"
@Field
def archiva = "archiva.closed.mzdev.be"
@Field
def chartmuseum = "chartmuseum.closed.mzdev.be"
@Field
def registry = "registry.closed.mzdev.be"
@Field
def nexus = "nexus.closed.mzdev.be"
@Field
def sonarqube = "sonarqube.closed.mzdev.be"
return this
