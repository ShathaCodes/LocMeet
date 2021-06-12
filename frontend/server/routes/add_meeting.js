const _ = require('lodash');
const Meeting = require('../models/Meeting');
const User = require('../models/User');
const Location = require('../models/Location');

const add_meeting = async (req, res) => {
    console.log(req.body);
    const meeting = req.body;
    const creator = req.body.creator;
    delete meeting.creator;

    const user = await User.findOne({ where: { id:creator } });
    try {
        const dbInstance = await Meeting.create(meeting);
        var loc = await  Location.create({
            lat:req.body.Location.lat,
            lng:req.body.Location.lng,
        });
        loc.setMeeting(dbInstance);
          console.log(dbInstance);
          dbInstance.setCreator(user);

        res.send(dbInstance);
    } catch (err) {
        if (err.original && err.original.errno === 1062) {
            res.status(400).send({ code: err.original.code });
        } else
            res.sendStatus(400);
    }
};

module.exports = add_meeting;