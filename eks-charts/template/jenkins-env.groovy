#!/usr/bin/groovy
import groovy.transform.Field
@Field
def role = "${role}"
@Field
def cluster = "${cluster}"
@Field
def base_domain = "${base_domain}"
@Field
def slack_token = "${slack_token}"
@Field
def jenkins = "${jenkins}"
@Field
def chartmuseum = "${chartmuseum}"
@Field
def registry = "${registry}"
@Field
def harbor = "${harbor}"
@Field
def archiva = "${archiva}"
@Field
def nexus = "${nexus}"
@Field
def sonarqube = "${sonarqube}"
return this
