#!/usr/bin/groovy
import groovy.transform.Field
@Field
def role = "devops"
@Field
def cluster = "eks-demo"
@Field
def base_domain = "demo.mzdev.be"
@Field
def slack_token = "REPLACEME/REPLACEME/REPLACEME"
@Field
def jenkins = "jenkins.demo.mzdev.be"
@Field
def harbor = "harbor-core.demo.mzdev.be"
@Field
def archiva = "archiva.demo.mzdev.be"
@Field
def chartmuseum = "chartmuseum.demo.mzdev.be"
@Field
def registry = "registry.demo.mzdev.be"
@Field
def nexus = "nexus.demo.mzdev.be"
@Field
def sonarqube = "sonarqube.demo.mzdev.be"
return this
