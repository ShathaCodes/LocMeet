const _ = require('lodash');
const Meeting = require('../models/Meeting');
const User = require('../models/User');
const Location = require('../models/Location');

const add_meeting = async (req, res) => {
    const meeting = req.body;
    const creator = req.body.creator;
    delete meeting.creator;
    //const location = JSON.parse(req.body.location);
    //delete meeting.location;

    const user = await User.findOne({ where: { id:creator } });
    try {
        const dbInstance = await Meeting.create(meeting, {
            include:  Location 
          });
          dbInstance.setCreator(user);
          user.setMeeting(dbInstance);
          await user.save();   
          
       /* var loc = await  Location.create(location);
        loc.setMeeting(dbInstance);*/

        res.send(dbInstance);
    } catch (err) {
        if (err.original && err.original.errno === 1062) {
            res.status(400).send({ code: err.original.code });
        } else
            res.sendStatus(400);
    }
};

module.exports = add_meeting;