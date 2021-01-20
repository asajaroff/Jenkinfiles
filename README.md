# Jenkinfiles

## Introduction

This repo aims to be a guide on how to build Pipelines using the [Jenkins plugin](https://plugins.jenkins.io/kubernetes/) for Kubernetes.

It's recommended to have some previous experience with the [Pod](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.19/#pod-v1-core) object, but it's not really necesary: the important thing that you need to have in mind when creating a Pipeline is that you must define and specify one or more containers to run your Jenkinsfile.

## Writing Pipelines
At the beginning of the Jenkinsfile we need to define which containers our build uses.

In Kubernetes, Jenkins agents are executed in the form of a pod with multiple containers: A jnpl main container and a subset of containers that we'll define.

The following example creates nodejs and golang containers to use within that Pipeline:
```groovy
podTemplate(containers: [
    containerTemplate(name: 'nodejs', image: 'node:15.6.0-stretch-slim', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'go', image: 'golang:1.14-stretch', ttyEnabled: true, command: 'cat'),
  ]) 
{
/** Pipeline **/
}
  ```

By default, the stages if not specified will run in the jnpl container:
```groovy
podTemplate {
    node(POD_LABEL) {
        stage('Run shell') {
            sh 'echo hello world'
        }
    }
}
```
If we need to run nodejs specific commands, such as `npm install` or `node ./script.js` we must invoke its execution within the `nodejs` container, as shown below:
```groovy
        container('nodejs') {
            stage('Build Depedencies') {
                    sh 'npm install'
                }
```