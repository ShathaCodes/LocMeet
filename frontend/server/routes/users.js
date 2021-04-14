const User = require('../models/User');
const Interest = require('../models/Interest');
const allusers = async (req, res) => {
    
    try {
        const users = await User.findAll({  include: Interest });
        //const resp = _.omit(users.dataValues, ['password', 'createdAt', 'updatedAt']);
        res.send(users);
        //console.log("All users:", JSON.stringify(interests, null, 2));
    } catch (err) {
    }
};

module.exports = allusers;