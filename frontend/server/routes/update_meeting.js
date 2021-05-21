const Meeting = require('../models/Meeting');

const edit_meeting = async (req, res) => {

          
          const meetingid = req.body.id;
          const date = req.body.date;

          const meeting = await Meeting.findOne({ where: { id:meetingid }});
       try{
           meeting.date = date;
        
        await meeting.save();   
        res.sendStatus(200);

    } catch (err) {
        res.status(400);
    }
};

module.exports = edit_meeting;