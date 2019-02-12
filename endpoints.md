# Bonita REST API endpoints 

Below are the list of covered endpoints and the ones that still need to be covered (PRs are welcome !)



## application API

https://documentation.bonitasoft.com/bonita/7.8/application-api



### Application 

- [ ] Create an application 
- [ ] Get an application
- [ ] Delete an application
- [ ] Update an application
- [ ] Search for an application



### Application Theme

- [ ] Update an application theme


### Application Menu

- [ ] Create an application menu item
- [ ] Get an application menu item
- [ ] Delete an application menu item
- [ ] Update an application menu item
- [ ] Search the application menu items



### Application Page

- [ ] Create an application page
- [ ] Get an application page
- [ ] Delete an application page
- [ ] Search for an application page



## access control API 

https://documentation.bonitasoft.com/bonita/7.8/access-control-api

### BDM 

- [ ] Get an access Control status
- [ ] Delete an access control



## bdm API 

https://documentation.bonitasoft.com/bonita/7.8/bdm-api



### BusinessData

- [x] Get the business data

- [ ] Get the business data attribute of business data 

- [x] Get several business data


### BusinessDataQuery

- [ ] Call a business data named query


### BusinessDataReference

- [ ] Get the named business data reference defined in the case
- [ ] Get the business data references defined in the case 



## bpm API

https://documentation.bonitasoft.com/bonita/7.8/bpm-api



### Activities and tasks

- [ ] Update activity variables 
- [ ] Update activity variables and execute a task 
- [ ] Skip activity
- [ ] Replay activity 
- [ ] Get an activity
- [ ] Search among activities
- [ ] Get an archived activity 
- [ ] Search among activities
- [ ] Retrieve a human task 
- [ ] Search for a human task 
- [ ] Update a humanTask
- [ ] Add a new subtask 
- [ ] Execute a subtask
- [ ] Retrieve a subtask 
- [ ] Search subtasks 



### Task 

- [ ] Read a task 
- [ ] Update a task 
- [ ] Search tasks 



### UserTask 

- [x] Retrieve a userTask 
- [x] Update a userTask 
- [ ] Retrieve the task contract 
- [x] Execute a task with contract 
- [x] Retrieve the userTask context



### ArchivedUserTask 

- [ ] Retrieve an archivedHumanTask 
- [ ] Search for a archivedHumanTask



### ArchivedManualTask

- [ ] Retrieve a subtask
- [ ] Search subtasks 



### ArchivedTask 

- [ ] Read an archived task 
- [ ] Search archived tasks



### ArchivedUserTask

- [ ] Retrieve an archivedUserTask
- [ ] Search for an archivedUserTask



### ActivityVariable

- [ ] Retrieving an activity instance variable 



### CaseVariable

- [x] Get a case variable
- [x] Update a case variable
- [x] Search for a list of case variables



### CaseDocument

- [ ] Add a document to a case 
- [ ] Get a document from a case
- [ ] Update a document for a case 
- [ ] Search for a document 
- [ ] Delete document 



### ArchivedCaseDocument

- [ ] Search for a document 
- [ ] Delete a document content



### Actors

- [ ] Read an actor
- [ ] Search actors for a given process id 
- [ ] Update an actor



### ActorMember

- [ ] Add a new actorMember
- [ ] Search actorMembers
- [ ] Delete an actorMember



### Cases

- [x] Read a case
- [x] Search for a case
- [x] Create a case
- [x] Delete a case
- [x] Delete cases in bulk
- [x] Retrieve the case context



### ArchivedCase

- [ ] Read an archived case
- [ ] Search archived cases
- [ ] Retrieve an archived case context 
- [ ] Remove an archived case



### CaseInfo

- [ ] Retrieve counters for case flow nodes 



### CaseComment 

- [ ] Create a comment 
- [ ] Search for comments 



### ArchivedCaseComment

- [ ] Search for archived comments 



### Process

- [ ] Deploy a process definition
- [x] Read a process
- [x] Update a process
- [x] Search for a process
- [ ] Retrieve the design for a process
- [ ] Retrieve the instantiation contract for a process
- [x] Start a process using an instantiation contract



### Diagram (Subscription editions only)

- [ ] Retrieve a process diagram xml file 



### ProcessParameter

- [ ] Read a processParameter 
- [ ] Search for a processParameter
- [ ] Update a processParameter (Subscription edition only)



### ProcessResolutionProblem

- [ ] Search for process resolution problems



### ProcessSupervisor

- [ ] Search for process supervisors of a given type (user, group, role or membership)
- [ ] Add a process Supervisor
- [ ] Delete a process supervisor 
- [ ] Delete process supervisors in bulk



### ProcessConnectorDependency

- [ ] Search for connector dependencies 



### Connector Failure

- [ ] Read a connector failure



### ConnectorInstance

- [ ] Retrieve a list of connector instances attached to a process or a flow node



### ArchivedConnectorInstance

- [ ] Retrieve a list of archived connector instances



### Flow Nodes 

- [ ] Get a flow node
- [ ] Search among Flow Nodes
- [ ] Change a Flow Node state



### ArchivedFlowNode

- [ ] Get an archived flow node 
- [ ] Search among archived flow nodes



### TimerEventTrigger

- [ ] Search for timer event triggers related to a case
- [ ] Update a timer event trigger next execution date



### Message 

- [ ] Send a message event

###  

## customuserinfo API 

https://documentation.bonitasoft.com/bonita/7.8/customuserinfo-api

### Definition

- [x] Add a new definition
- [x] Delete a definition
- [x] List the custom user information



### User 

- [x] Search customer user info



### Value 

- [x] Associate definitions to users 



## form API 

https://documentation.bonitasoft.com/bonita/7.8/form-api



### Form mapping 

- [ ] Search for a form mapping 
- [ ] Update a form mapping 





## identity API

https://documentation.bonitasoft.com/bonita/7.8/identity-api



### professionalcontactdata and personalcontactdata

- [ ] Create a contact information
- [ ] Read a user's contact information 
- [ ] Update a user's contact information



### Group

- [x] Create a group
- [x] Read a group
- [x] Search for a group
- [x] Update a group
- [x] Delete a group



### Membership

- [x] Create a membership
- [x] Search memberships of a user
- [x] Delete a membership



### Role

- [x] Create a role
- [x] Read a role
- [x] Search for a role
- [x] Update a role
- [x] Delete a role



### User

- [x] Create a user
- [x] Read a user details
- [x] Search for a group of users
- [x] Update a user
- [x] Remove a user



## platform API

https://documentation.bonitasoft.com/bonita/7.8/platform-api

- [ ] Login 
- [ ] Logout 



### Platform 

- [ ] Get the platform 

- [ ] Start or stop the platform

- [ ] Get a tenant 


### Tenant 

- [ ] Create a tenant 
- [ ] Update a tenant 
- [ ] Delete a tenant 



### License

- [ ] Get subscription license information 





## portal API 

https://documentation.bonitasoft.com/bonita/7.8/portal-api



### Page 

- [ ] Retrieve a Custom Page 
- [ ] Add a new custom page 
- [ ] Update a custom page
- [ ] Search custom pages
- [ ] Delete a custom page 



### Profile 

- [x] Retrieve a Profile
- [x] Add a new profile
- [x] Update a profile
- [x] Search profiles
- [x] Delete a profile



### ProfileEntry 

- [ ] Retrieve a profileEntry
- [ ] Add a new profileEntry
- [ ] Update a profileEntry
- [ ] Search profileEntry items
- [ ] Delete a profileEntry



### ProfileMember

- [x] Add a new profileMember
- [x] Search profileMembers
- [x] Delete a profileMember



### Theme 

- [ ] Change a theme
- [ ] Restore a default theme



## system API 

https://documentation.bonitasoft.com/bonita/7.8/system-api



### i18nlocale 

- [ ] List available locales 



### i18ntranslation

- [ ] List available translations 



### Session

- [ ] Get the current session



### Tenant

- [ ] Get the current tenant
- [ ] Pause or resume the current tenant





## tenant API

https://documentation.bonitasoft.com/bonita/7.8/tenant-api



### BDM 

- [ ] Get BDM status 
- [ ] Upload a bdm
- [ ] Install/Update a file previously uploaded























