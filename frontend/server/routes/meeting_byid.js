const Meeting = require('../models/Meeting');
const User = require('../models/User');
const Location = require('../models/Location');

const meetings = async (req, res) => {
    
    try {
        
        const meeting = await Meeting.findAll({ include: [
            {
               model: User, as: "creator"
            },
            {
                model: User, as: "guests"
             },
             {
                model: Location
             },
          ]
           });
        res.send(meeting);
        
    } catch (err) {
    }
};

module.exports = meetings;