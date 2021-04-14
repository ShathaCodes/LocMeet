const User = require('../models/User');
const Interest = require('../models/Interest');
const { authErrorString } = require('../config/values');

const update_user = async (req, res) => {
  /*
    const idd = req.body.id;
    const user = await User.findOne({ where: { idd },  include: Interest });
    const interests = req.body.interests;
    try {
        user.nickname=req.body.user.nickname;
        user.password=req.body.user.password;
        user.location=req.body.user.location;
        //console.log(user.Interests);
        for (const item of user.Interests) {  
            var id = item.id;
            const inter = await Interest.findOne({ where: { id } });
            await user.removeInterest(inter);
            console.log(id);
            
          }
          for (const item of interests) {  
            var id = item.id;
            const inter = await Interest.findOne({ where: { id } });
            await user.addInterest(inter);
            console.log(id);
            
          }
        */
          const newuser = req.body;
          const id = req.body.id;
          const interests = req.body.interests;
          const user = await User.findOne({ where: { id },  include: Interest });
          
       try{

        user.nickname=newuser.nickname;
        user.password=newuser.password;
        user.location=newuser.location;
        for (const item of user.Interests) {  
          var id2 = item.id;
          const inter = await Interest.findOne({ where: { id :id2 } });
          await user.removeInterest(inter);
        }
        for (const item of interests) { 
          if(Number.isInteger(parseInt(item))) {
          console.log(item);
          const inter = await Interest.findOne({ where: { id:item } });
          await user.addInterest(inter);
          }
        }

        await user.save();     

        const token = await User.generateAuthToken(req.body.nickname, req.body.password);
        res.send({ token });
    } catch (err) {
        res.status(401).send(authErrorString);
    }
    
};

module.exports = update_user;