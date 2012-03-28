var fs = require('fs').readFileSync(__dirname + '/restaurant.html');
var http = require('http').createServer(function(req, res) {
    res.end(fs);
});
http.listen(8000);

var nowjs = require("now");
var customer = nowjs.initialize(http);

// yes or no
customer.now.decisionList = {'Yes':'Yes','No':'No'};

// List of costumer
customer.now.customerList = {'Customer1':'Customer 1','Customer2':'Customer 2'};

// Send message to particular customer
customer.now.distributeMessage = function(message) {
    var group = nowjs.getGroup(this.now.Customer);
    group.now.receiveMessage('Hi ' + this.now.Customer + ', ' + this.now.Decision + ', ' + message);
};

customer.now.changeDecision = function(dec) {
  this.now.Decision = dec;
};

customer.now.changeCustomer = function(otherCustomer) {
    var prevCustomer = this.now.Customer;
    if(prevCustomer){
        var oldGroup = nowjs.getGroup(prevCustomer);
        oldGroup.removeUser(this.user.clientId);
    }
    var newGroup = nowjs.getGroup(otherCustomer);
    newGroup.addUser(this.user.clientId);
    this.now.Customer = otherCustomer;
};
