Router.configure
	notFoundTemplate: 'notFound'
	progressTick : false

OnBeforeActions = 
	loginRequired: (pause) ->
		
		if !Meteor.userId() && !@params.invitationId
			Router.go "login"

		if Meteor.userId()
			if Meteor.user().profile.isActive && @params.invitationId
				Router.go('/')
			else
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

if(Meteor.isServer)
	FastRender.onAllRoutes ()->
		Meteor.subscribe 'answers'
		Meteor.subscribe 'results'
		Meteor.subscribe 'days'
		Meteor.subscribe 'adminUsers'

Router.map ->
	@route "/",
		path           : "/"
		layoutTemplate : "home"
		fastRender: true
		waitOn: ()->
			Meteor.subscribe 'answers'
			Meteor.subscribe 'days'
			Meteor.subscribe 'results'

	@route 'shopping-list',
		path           : ['/shopping-list/']
		layoutTemplate : 'shoppingList'
		fastRender: true
		cache: true
		waitOn: ()->
			Meteor.subscribe 'results'
			Meteor.subscribe 'days'
			Meteor.subscribe 'answers'
		data: ->
			day = Days.findOne 'sort' : 6
			answer = Answers.findOne
				dayId: day._id
				userId: Meteor.userId()
			console.log answer
			if answer
				if typeof answer.data == 'string'
					answer.data = JSON.parse(answer.data)
				if answer.data.t2
					return {
						table: answer.data.t2.value
					}

	@route 'days',
		path           : ['/days/:dayCode']
		layoutTemplate : 'dayDetail'
		fastRender: true
		cache: true
		waitOn: ()->
			Meteor.subscribe 'adminUsers'
			Meteor.subscribe 'results'
			Meteor.subscribe 'days'
			Meteor.subscribe 'answers', onReady = ()->
				Session.set 'dayLoaded', true	
			
		data: ->
			day = Days.findOne 'sort' : parseInt @params.dayCode
			if day
				if moment(day.date) < moment() || Roles.userIsInRole Meteor.userId(), ['admin']
					day.isActive = true
				else
					day.isActive = false
				data = 
					Day : day
					templateName: "Days#{day.sort}"

				return data
	
	@route 'signup',
		path           : ['/signup/:invitationId']
		layoutTemplate : 'singup'
		waitOn : ()->
			@dataLoaded = Meteor.subscribe 'invitations', @params.invitationId, onReady = ()->
				Session.set 'Loaded', true
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