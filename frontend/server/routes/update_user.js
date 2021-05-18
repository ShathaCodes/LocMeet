const User = require('../models/User');
const Interest = require('../models/Interest');
const { authErrorString } = require('../config/values');

const update_user = async (req, res) => {
          const newuser = req.body;
          const id = req.body.id;
          const interests = JSON.parse(req.body.interests);
          const user = await User.findOne({ where: { id },  include: Interest });
          
       try{

        user.nickname=newuser.nickname;
        if(newuser.password != "")
        user.password=newuser.password;
        
        for (const item of user.Interests) {  
          var id2 = item.id;
          const inter = await Interest.findOne({ where: { id :id2 } });
          await user.removeInterest(inter);
        }
        for (const item of interests) { 
          //if(Number.isInteger(parseInt(item))) {
          console.log(item);
          const inter = await Interest.findOne({ where: { name:item } });
          console.log(inter);
          await dbInstance.addInterest(inter);
          //}
        }

        await user.save();     

        const token = await User.generateAuthToken(req.body.nickname, req.body.password);
        res.send({ token });
    } catch (err) {
        res.status(401).send(authErrorString);
    }
    
};

module.exports = update_user;