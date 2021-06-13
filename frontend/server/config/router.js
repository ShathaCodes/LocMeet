const login = require('../routes/login');
const register = require('../routes/register');
const interests = require('../routes/interests');
const delete_user = require('../routes/delete_user');
const update_user = require('../routes/update_user');
const users = require('../routes/users');
const therapists = require('../routes/therapists');
const add_therapist = require('../routes/add_therapist');
const add_interest = require('../routes/add_interest');
const nearby = require('../routes/nearby');
const update_location = require('../routes/update_location');

const meetings = require('../routes/meetings');
const add_meeting = require('../routes/add_meeting');
const join_meeting = require('../routes/join_meeting');
const abandon_meeting = require('../routes/abandon_meeting');
const delete_meeting = require('../routes/delete_meeting');
const update_meeting = require('../routes/update_meeting');

const Pusher = require("pusher");
const pusher = new Pusher({
    appId : "1218585",
    key : "0e149bbe91658d657887",
    secret : "910b661f463ea8969b88",
    cluster : "eu",
    useTLS: true,
});

const router = {
    initialize: (app, passport) => {
        const authenticate = passport.authenticate('jwt', { session: false });
        
        app.post('/login', login );
        app.post('/register', register);
        app.get('/interests', interests);
        app.post('/delete_user', delete_user);
        app.post('/update_user', update_user);
        app.get('/users', users);
        app.get('/therapists', therapists);
        app.post('/add_interest', add_interest);
        app.post('/add_therapist', add_therapist);
        app.get('/nearby', nearby);
        app.post('/update_location', update_location);
        app.post("/pusher/auth", (req, res) => {
            const socketId = req.body.socket_id;
            const channel = req.body.channel_name;
            const auth = pusher.authenticate(socketId, channel);
            res.send(auth);
        });
        app.get('/meetings', meetings);
        app.post('/add_meeting', add_meeting);
        app.post('/join_meeting', join_meeting);
        app.post('/abandon_meeting', abandon_meeting);
        app.post('/delete_meeting', delete_meeting);
        app.post('/update_meeting', update_meeting);

    }
};

module.exports = router;
