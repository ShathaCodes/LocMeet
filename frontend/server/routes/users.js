const User = require('../models/User');
const Interest = require('../models/Interest');
const Location = require('../models/Location');
const Meeting = require('../models/Meeting');


const allusers = async (req, res) => {
    
    try {
        const users = await User.findAll({attributes: { exclude: ['password', 'createdAt', 'updatedAt'] },  include: [Location,Interest,{model :Meeting, as :'meeting'},{model :Meeting, as :'meetings'}]});
        //const resp = _.omit(users.dataValues, ['password', 'createdAt', 'updatedAt']);
        res.send(users);
        //console.log("All users:", JSON.stringify(interests, null, 2));
    } catch (err) {
    }
};

module.exports = allusers;