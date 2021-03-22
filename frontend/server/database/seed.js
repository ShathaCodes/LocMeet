const { User,Interest } = require ('./models')

const seed = async () => {
    
    let users = [
        User.create({
            nickname: 'username1',
            password: 'admin1',
            location:'loc',
            isAdmin: true,
            
        }),
        User.create({
            nickname: 'username2',
            password: 'admin2',
            location:'loc',
            isAdmin: true
        })];
        let interests = [
            Interest.create({
                name: 'sport',
            }),
            Interest.create({
                name: 'baking',
            }),
            Interest.create({
                name: 'crochet',
            }),
            Interest.create({
                name: 'chess',
            }),
            Interest.create({
                name:'music'
            }),
            Interest.create({
                name:'books'
            })
            
        ];
        //users[0].addInterest(interests[0]);
        //users[0].addInterest(interests[2]);
        //users[1].addInterest(interests[2]);
}

module.exports = seed;