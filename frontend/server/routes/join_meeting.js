
const Meeting = require('../models/Meeting');
const User = require('../models/User');


const join_meeting = async (req, res) => {

          const userid = req.body.user;
          const meetingid = req.body.meeting;
          const user = await User.findOne({ where: { id:userid }});
          const meeting = await Meeting.findOne({ where: { id:meetingid }});
       try{
           meeting.addGuests(user);
        await meeting.save();   
        res.sendStatus(200);

    } catch (err) {
        res.status(400);
    }
};

module.exports = join_meeting;