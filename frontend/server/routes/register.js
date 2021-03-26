const _ = require('lodash');
const Interest = require('../models/Interest');

const User = require('../models/User');

const register = async (req, res) => {
    const user = req.body.user;
    const interests = req.body.interests;
    try {
        
        const dbInstance = await User.create(user);
        for (const item of interests) {  
            var id = item.id;
            const inter = await Interest.findOne({ where: { id } });
            await dbInstance.addInterest(inter);
          }
        const responseDbInstance = _.omit(dbInstance.dataValues, ['password', 'createdAt', 'updatedAt']);
        res.send(responseDbInstance);
    } catch (err) {
        if (err.original && err.original.errno === 1062) {
            res.status(400).send({ code: err.original.code });
        } else
            res.sendStatus(400);
    }
};

module.exports = register;
