const login = require('../routes/login');
const register = require('../routes/register');
const interests = require('../routes/interests');
const delete_user = require('../routes/delete_user');
const update_user = require('../routes/update_user');
const users = require('../routes/users');
const therapists = require('../routes/therapists');
const add_therapist = require('../routes/add_therapist');
const add_interest = require('../routes/add_interest');

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

    }
};

module.exports = router;
