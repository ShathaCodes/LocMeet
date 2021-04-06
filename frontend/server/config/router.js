const login = require('../routes/login');
const register = require('../routes/register');
const interests = require('../routes/interests');

const router = {
    initialize: (app, passport) => {
        const authenticate = passport.authenticate('jwt', { session: false });
        
        app.post('/login', login );
        app.post('/register', register);
        app.get('/interests', interests);
    }
};

module.exports = router;
