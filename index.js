const axios = require('axios').default;

const getIP = async () => {
   const res = await axios.get('https://api.ipify.org/?format=json');
   return res.data;
}

module.exports = getIP;