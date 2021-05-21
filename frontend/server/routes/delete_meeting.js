const Meeting = require('../models/Meeting');

const delete_meeting = async (req, res) => {

    const id = req.body.id;
    try{
        //const user = await User.findOne({ where: { id } });
        await Meeting.destroy({ where: { id } });
        res.sendStatus(202);
    }
    catch(err){
        res.sendStatus(400);
    }
    
};

module.exports = delete_meeting;