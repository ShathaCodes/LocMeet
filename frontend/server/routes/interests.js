const Interest = require('../models/Interest');

const allinterests = async (req, res) => {
    
    try {
        const interests = await Interest.findAll();
        res.send(interests);
        //console.log("All users:", JSON.stringify(interests, null, 2));
    } catch (err) {
    }
};

module.exports = allinterests;