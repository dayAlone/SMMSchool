Router.configure
	notFoundTemplate: 'notFound'

OnBeforeActions = 
	loginRequired: (pause) ->
		if !Meteor.userId() && !@params.invitationId
			Router.go "login"

		if Meteor.userId()
			if @params.invitationId
				invite = Invitations.findOne
					invitationId: @params.invitationId
					used: false
				if invite
					Meteor.call('activeUser', invite)
					Router.go('/')
				else
					Router.go('errorSignup')

			else
				if !Meteor.user().profile.isActive
					Router.go('errorSignup')
		@next()
	userCheck: ()->
		if Meteor.userId()
				if Meteor.user().profile.isActive
					Router.go('/')
				else
					Router.go('errorSignup')
			this.next()

Router.onBeforeAction OnBeforeActions.loginRequired, except: ['login']

Router.map ->
	@route "/",
		path           : "/"
		layoutTemplate : "home"

	@route 'days',
		path           : ['/days/:dayCode']
		layoutTemplate : 'dayDetail'
		data: ->
			day = Days.findOne 'sort' : parseInt @params.dayCode
			if day
				if moment(day.date) < moment()
					day.isActive = true
				else
					day.isActive = false
				return {
					Day : day
					templateName : "Days#{day.sort}"
				}
			else
				Router.go('notFound')
	
	@route 'signup',
		path           : ['/signup/:invitationId']
		layoutTemplate : 'singup'
		data: ->
			return {
				invitationId: Invitations.findOne
					invitationId: @params.invitationId
					used: false
			}

	@route "login",
		path           : "login"
		layoutTemplate : "login"
		onBeforeAction : OnBeforeActions.userCheck
			
	@route "notFound",
		layoutTemplate : "notFound"

	@route "errorSignup",
		path           : "errorSignup"
		layoutTemplate : "errorSignup"
		onBeforeAction : OnBeforeActions.userCheck