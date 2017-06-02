@Library('libpipelines@master') _

hose {
   EMAIL = 'architecture'
   MODULE = 'java-microservice-dockerbase'
   REPOSITORY = 'github.com/java-ms-dockerbase'
   BUILDTOOL = 'make'
   DEVTIMEOUT = 30
   RELEASETIMEOUT = 30

   PKGMODULESNAMES = ['java-microservice-dockerbase']

   DEV = { config ->      
      doDocker(config)
   }
}
