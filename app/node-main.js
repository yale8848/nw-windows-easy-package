/**
 * Created by yale on 15-4-11.
 */

//https://github.com/nwjs/nw.js/issues/1699
/*------------ Uncaught Nodejs Error prevent and Logger-----------*/

process.on('uncaughtException', function(e){
    console.group('Node uncaughtException');
    if(!!e.message){
        console.log(e.message);
    }
    if(!!e.stack){
        console.log(e.stack);
    }
    console.log(e);
    console.groupEnd();
});

/*------------ Uncaught Nodejs Error prevent and Logger-----------*/


