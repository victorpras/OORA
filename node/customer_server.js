var fs = require('fs').readFileSync(__dirname + '/customer.html');
var http = require('http').createServer(function(req, res) {
    res.end(fs);
});
http.listen(8000);

var nowjs = require("now");
var restaurant = nowjs.initialize(http);

//List of available restaurants
restaurant.now.restaurantList = {'rest1':'Restaurant 1','rest2':'Restaurant 2','rest3':'Restaurant 3'};

//List of menus
restaurant.now.menuList = {'Burger':'Burger','Pasta':'Pasta','Lobster':'Lobster'};

// Send message to particular restaurant
restaurant.now.distributeMessage = function(message) {
    var group = nowjs.getGroup(this.now.Restaurant);
    group.now.receiveMessage(this.now.name, ' wants to order '+ message + ' ' + this.now.Menu);
};

restaurant.now.changeMenu = function(menu) {
  this.now.Menu = menu;
};

restaurant.now.changeRestaurant = function(newRestaurant) {
    var oldRestaurant = this.now.Restaurant;
    console.log('Customer picks another restaurant');
    if(oldRestaurant){
        var oldGroup = nowjs.getGroup(oldRestaurant);
        oldGroup.removeUser(this.user.clientId);
    }
    var newGroup = nowjs.getGroup(newRestaurant);
    newGroup.addUser(this.user.clientId);
    newGroup.now.receiveMessage(this.now.name, ' is initiating an order...');
    this.now.Restaurant = newRestaurant;
};
