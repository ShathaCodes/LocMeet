
const Location = require('../models/Location');

const update_location = async (req, res) => {

          const id = req.body.id;
          const loc = await Location.findOne({ where: { id:id }});
       try{
        loc.lat = req.body.lat;
        loc.lng = req.body.lng;
        loc.show = req.body.show;

        await loc.save();   

        /*var user = await User.findBy(
            {   
                attributes: { exclude: ['password', 'createdAt', 'updatedAt'] },
                include: [{
                    model: Location,
                    where: {
                        id : id
                        }, 
                  },
                {
                    model: Interest,
                }]
                });

        const token = await User.generateAuthToken(user.nickname, user.password);
        res.send({ token });  */
        res.sendStatus(200);

    } catch (err) {
        res.status(400);
    }
    
};

module.exports = update_location;