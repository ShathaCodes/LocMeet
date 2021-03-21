const User = require('../models/User');
const { authErrorString } = require('../config/values');


const login = async (req, res) => {

    const nickname = req.body.nickname;

    const clearTextPassword = req.body.password;


    try {
        const token = await User.generateAuthToken(nickname, clearTextPassword);
        res.send({ token });
    } catch (err) {
        res.status(401).send(authErrorString);
    }
};

module.exports = login;