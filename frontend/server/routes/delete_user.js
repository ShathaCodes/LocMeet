const User = require('../models/User');



const delete_user = async (req, res) => {

    const id = req.body.id;
    try{
        //const user = await User.findOne({ where: { id } });
        await User.destroy({ where: { id } });
        res.sendStatus(202);
    }
    catch(err){
        res.sendStatus(400);
    }
    
};

module.exports = delete_user;