#!/usr/bin/groovy
import groovy.transform.Field
@Field
def role = "devops"
@Field
def cluster = "eks-demo"
@Field
def base_domain = "demo.spic.me"
@Field
def slack_token = "REPLACEME/REPLACEME/REPLACEME"
@Field
def jenkins = "jenkins.demo.spic.me"
@Field
def harbor = "harbor-core.demo.spic.me"
@Field
def archiva = "archiva.demo.spic.me"
@Field
def chartmuseum = "chartmuseum.demo.spic.me"
@Field
def registry = "registry.demo.spic.me"
@Field
def nexus = "nexus.demo.spic.me"
@Field
def sonarqube = "sonarqube.demo.spic.me"
return this
