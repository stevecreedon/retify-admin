angular.module('lovebnb.factories.messages', [])
  .factory 'Messages', () ->
    errors:
      required: "can't be blank"
    user:
      verify: "Please verify your email address. <a href='#/verification'>Send again</a>"
