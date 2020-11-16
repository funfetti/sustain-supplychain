#!/usr/bin/env bash

sfdx shane:user:psl -l User -g User -n sustain_app_SustainabilityCloudPsl
sfdx shane:user:psl -l User -g User -n InsightsInboxAdminAnalyticsPsl

sfdx force:user:permset:assign -n SustainabilityAnalytics
sfdx force:user:permset:assign -n SustainabilityAppAuditor
sfdx force:user:permset:assign -n SustainabilityAppManager
sfdx force:user:permset:assign -n SustainabilityCloud

### loading
# configs 
sfdx force:source:push 

# data
sfdx automig:load -d demo-data -m RecordType:DeveloperName,sustain_app__EmissionFactorScope3__c:Name

### EA stuff
# make the EA dashboards populate correctly 
#sfdx shane:user:permset:assign -l User -g Integration -n SustainabilityAnalytics
#create EA apps
#sfdx analytics:app:create -m Sustainability  
#sfdx analytics:app:create -m Sustainability_Audit -a 

# open the org 
echo "open sesame..."
sfdx force:org:open