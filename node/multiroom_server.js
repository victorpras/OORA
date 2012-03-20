
var html = require('fs').readFileSync(__dirname+'/multiroom.html');
var server = require('http').createServer(function(req, res){
    res.end(html);
});
server.listen(8080);

var nowjs = require("now");
var everyone = nowjs.initialize(server);

// List of available rooms
everyone.now.serverRoomsList = {'burger':'Burger','pasta':'Pasta','lobster':'Lobster'};

// Send message to everyone on the users group
everyone.now.distributeMessage = function(message){
    //console.log('Received message from '+this.now.name +' in serverroom '+this.now.serverRoom);
    var group = nowjs.getGroup(this.now.serverRoom);
    group.now.receiveMessage(this.now.name, 'wants to order '+ message + 'x ' + this.now.serverRoom);
};

everyone.now.changeRoom = function(newRoom){
    var oldRoom = this.now.serverRoom;
    console.log('Changed user '+this.now.name + ' from '+oldRoom + ' to '+newRoom);
    //if old room is not null; then leave the old room
    if(oldRoom){
        var oldGroup = nowjs.getGroup(oldRoom);
        oldGroup.removeUser(this.user.clientId);
        // Tell everyone he left :)
        oldGroup.now.receiveMessage('', this.now.name + ' has left the room and gone to '+newRoom);
    }
    var newGroup = nowjs.getGroup(newRoom);
    newGroup.addUser(this.user.clientId);
    // Tell everyone he joined
    newGroup.now.receiveMessage('', this.now.name + ' is initiating an order...');
    this.now.serverRoom = newRoom;
};