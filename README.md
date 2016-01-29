# openshift-mojolicious

Template for running a mojolicious container.

# Installation

You need oc (li tool) locally installed

###Create a new project
```sh
oc new-project openshift-mojolicious \
    --description="mojolicious on openshift" \
    --display-name="Mojolicious"
```
###Clone the repository
```sh
git clone https://github.com/ure/openshift-mojolicious.git
```

###Create a PersistentVolumeClaim
```sh
oc create -f GlusterFS-Cluster.yaml
oc create -f PersistentVolumeClaim.yaml
```

###Build Wordpress app

```sh
oc create -f BuildConfig.yaml
oc create -f DeploymentConfig.yaml
oc new-app https://github.com/ure/openshift-mojolicious.git
oc start-build openshift-mojolicious
```

###Build a dynamic Route
```sh
oc create -f Route.yaml
```

###Build a static Route
(for production and optionally delete the development route)
```sh
oc delete -f Route.yaml
oc create -f ProductionRoute.yaml
```

###Mail the world
this is done with ssmtp ... edit files in /ssmtp directory accordingly

#Optionally for deployments from a private repository
###Create a new repository

###Modify sources to your repository name
```sh
perl -i -pe 's/openshift-mojolicious/yourreponame/g' *
```

###Generate BuildConfig
```sh
rm -f BuildConfig.yaml
./genwebhooksecret.sh
```
edit BuildConfig.yaml & DeploymentConfig.yaml and modify you repository location

###Create an ssh deploy key without passphrase
```sh
ssh-keygen -f ~/.ssh/openshift-mojolicious
cat ~/.ssh/openshift-mojolicious.pub
```
add output to the deployment keys on your private repository

###Add your secrets to your project
```sh
oc secrets new-sshauth openshift-mojolicious --ssh-privatekey=/home/joeri/.ssh/openshift-mojolicious
oc secrets add serviceaccount/builder secrets/openshift-mojolicious
```
###Deploy from private git repository
```sh
oc new-app .
```
