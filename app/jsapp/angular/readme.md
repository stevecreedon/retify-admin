# changes in angular-resource.js

* added update => PUT to the DEFAULT_ACTIONS

```
var DEFAULT_ACTIONS = {
  'get':    {method:'GET'},
  'save':   {method:'POST'},
  'update': {method:'PUT'},
  'query':  {method:'GET', isArray:true},
  'remove': {method:'DELETE'},
  'delete': {method:'DELETE'}
};
```
