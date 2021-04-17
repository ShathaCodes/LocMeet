const Therapist = require('../models/Therapist');

const alltherapists = async (req, res) => {
    
    try {
        const therapists = await Therapist.findAll();
        res.send(therapists);
        //console.log("All users:", JSON.stringify(interests, null, 2));
    } catch (err) {
    }
};

module.exports = alltherapists;