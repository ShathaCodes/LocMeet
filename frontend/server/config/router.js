const login = require('../routes/login');
const register = require('../routes/register');
const interests = require('../routes/interests');
const delete_user = require('../routes/delete_user');
const update_user = require('../routes/update_user');
const users = require('../routes/users');


const router = {
    initialize: (app, passport) => {
        const authenticate = passport.authenticate('jwt', { session: false });
        
        app.post('/login', login );
        app.post('/register', register);
        app.get('/interests', interests);
        app.post('/delete_user', delete_user);
        app.post('/update_user', update_user);
        app.get('/users', users);

    }
};

module.exports = router;
