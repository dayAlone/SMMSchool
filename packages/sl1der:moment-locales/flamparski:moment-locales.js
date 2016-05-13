if (typeof moment !== 'undefined') {
//  console.log('we have moment');
} else if (typeof Meteor.__moment !== 'undefined') {
//  console.log('moment is in Meteor.__moment: exposing to global');
  moment = Meteor.__moment;
}
