const express = require("express");
const bodyParser = require("body-parser");
const cron = require("node-cron");
const fetch = require("node-fetch");
const isReachable = require('is-reachable');

const app = express();
const nodemailer = require("nodemailer");
const mail = require("nodemailer/lib/mailer");
const { query } = require("express");
const { json } = require("body-parser");
// const { json } = require("express");
// const transporter = nodemailer.createTransport('smtp://'+process.env.SMTP_LOGIN+':'+process.env.SMTP_PASSWORD+'@'+process.env.SMTP_HOST);
const transporter = nodemailer.createTransport({
  host: 'smtp.kemenkeu.go.id',
  port: 25,
  secure: false,
  tls: { rejectUnauthorized: false },
});

const PORT = process.env.PORT || 3000;

app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(bodyParser.json());


app.post('/hello', async (req, res) => {
  return res.json({
    hello: "world"
  });
});

const HASURA_OPERATION = `
mutation ($object: event_insert_input!) {
  insert_event_one(object: $object) {
    id
  }
}
`;

const HASURA_SHOW_TODAY_EMAIL_LIST = `
query myquery($_lte: timestamptz = "2080-03-03T17:00:00.000Z") {
  vm_alloc_email_schedule(where: {_and: {date: {_lte: $_lte}, status: {_neq: "1"}}}) {
    id
    date
    state
    status
    server {
      ip
      server_name
      owner {
        owner
        email
      }
    }
  }
}


`;

const HASURA_UPDATE_AFTER_SEND_EMAIL = `
mutation mymutation($_eq: Int = 10, $status: smallint = 0) {
  update_vm_alloc_email_schedule(_set: {status: $status}, where: {id: {_eq: $_eq}}) {
    affected_rows
  }
}
`;

const emailDefault = 'Default';
const statePowerOn = 'Server has been Power On';
const stateNotif = 'Server is going to die (Power Off)';
const statePowerOff = 'Server has been Power Off';
const stateDelete = 'Server need to be deleted';

// var graphqlServer = '192.168.194.136:8080';
var graphqlServer = '10.242.65.23:8002';

const isGraphQLServerConnected = () => {
  (async () => {
    var isConnected = await isReachable(graphqlServer);
    if (!isConnected) {
      console.log('GraphQL server is not connected, please check your GraphQL server');
      return;
    } else console.log('GraphQL server is connected');
    //=> true
  })();
}

const isServerReadyToSendEmail = () => {
  transporter.verify(function async(error, success) {
    if (error) {
      // console.log(error);
      console.log('Email function is not working, please check smtp configuration on smtp server')
      return;
    } else {
      console.log("Server is ready to send email");
    }
  });
}

const getTodayAndTomorrowDate = () => {
  let todayDate = new Date();
  let tomorrowDate = new Date();
  todayDate.setHours(0, 0, 0, 0);
  tomorrowDate.setDate(todayDate.getDate() + 1);
  tomorrowDate.setHours(0, 0, 0, 0);
  return { todayDate, tomorrowDate }
  // console.log(todayDate.toISOString());
  // console.log(tomorrowDate.toISOString());
}

const sendHasura = (query, variables, headers) => {
  const fetchResponse = fetch(
    'http://' + graphqlServer + '/v1/graphql',
    {
      method: 'POST',
      body: JSON.stringify({
        query: query,
        variables: variables,
      }),
      headers: {
        'x-hasura-admin-secret': 'ordo123OK',
        ...headers
      }
    }
  ).then(res => res.json());


  // const data = fetchResponse.json();
  // console.log('DEBUG: ', data);
  // return data;
  return fetchResponse;
};

async function wrapedSendMail(mailOptions) {
  return new Promise((resolve, reject) => {
    // let transporter = nodemailer.createTransport({//settings});

    transporter.sendMail(mailOptions, function (error, info) {
      if (error) {
        console.log("error is " + error);
        resolve(false); // or use rejcet(false) but then you will have to handle errors
      }
      else {
        console.log('Email sent: ' + info.response);
        resolve(true);
      }
    });
  }
  )
}

cron.schedule('0 */6 * * *', async () => {
  console.log('================= begin ===============');
  let now = new Date();
  console.log('time : ' + now);
  isGraphQLServerConnected();
  isServerReadyToSendEmail();
  let { todayDate, tomorrowDate } = getTodayAndTomorrowDate();

  const { data, errors } = await sendHasura(
    HASURA_SHOW_TODAY_EMAIL_LIST,
    {
      // '_gte': todayDate.toISOString(), 
      '_lte': tomorrowDate.toISOString()
    },
    { 'content-type': 'application/json' }
  );


  // if Hasura operation errors, then throw error
  if (errors) {
    console.log('error fetching data from GraphQL');
    return;
  }
  console.log('received data :')
  console.log(data);

  var { vm_alloc_email_schedule } = data;
  if (vm_alloc_email_schedule.length <= 0) {
    console.log('no email to send today');
    return;
  };

  for (let i = 0; i < vm_alloc_email_schedule.length; i++) {
    let server_email_schedule = vm_alloc_email_schedule[i];
    let id_email_schedule = server_email_schedule.id;
    let { date } = server_email_schedule;
    let state = server_email_schedule.state;
    let status = server_email_schedule.status;
    let { server } = server_email_schedule;
    let { ip } = server;
    let { server_name } = server;
    let { owner } = server;
    let owner_name = owner.owner;
    let { email } = owner;
    // console.log(id_email_schedule);
    // console.log(date);
    // console.log(state);
    // console.log(status);
    // console.log(ip);
    // console.log(server_name);
    // console.log(owner_name);
    // console.log(email);


    // run some business logic
    const from_email = 'alertnoc@kemenkeu.go.id';
    const senders = 'Subbidang Pengelolaan Server DC Kemenkeu';
    const ccs = ['pengserver.pusintek@kemenkeu.go.id'];
    // ['pengserver.pusintek@kemenkeu.go.id', 'ifpd.pusintek@kemenkeu.go.id']
    const subjects = 'Permberitahuan Status Server Development';
    let serverState = '';
    let emailBody = '';

    switch (state) {
      case 0:
        serverState = statePowerOn;
        emailBody = `
        <body>
        <p>Yth. Bapak/Ibu `+ owner_name + `,</p>
        <p>Berikut kami sampaikan server anda telah POWER ON :</p>
        <table>
            <tr>
                <td>Nama Server</td>
                <td>:</td>
                <td>`+ server_name + `</td>
            </tr>
            <tr>
                <td>IP</td>
                <td>:</td>
                <td>`+ ip + `</td>
            </tr>
        </table>

        <p> Demikian kami sampaikan atas perhatiannya kami ucapkan terima kasih​ .</p>
        `;
        break;
      case 1:
        serverState = stateNotif;
        emailBody = `
        <body>
        <p>Yth. Bapak/Ibu `+ owner_name + `,</p>
        <p>Berikut kami sampaikan server anda akan dilakukan POWER OFF :</p>
        <table>
            <tr>
                <td>Nama Server</td>
                <td>:</td>
                <td>`+ server_name + `</td>
            </tr>
            <tr>
                <td>IP</td>
                <td>:</td>
                <td>`+ ip + `</td>
            </tr>
        </table>

        <p>Apabila Bapak/Ibu akan memperpanjang masa aktif server, mohon dapat menghubungi pengserver.pusintek@kemenkeu.go.id, apabila tidak diperpanjang server akan kami hapus</p>

        <p> Demikian kami sampaikan atas perhatiannya kami ucapkan terima kasih​ .</p>
        `;
        break;
      case 2:
        serverState = statePowerOff;
        emailBody = `
        <body>
        <p>Yth. Bapak/Ibu `+ owner_name + `,</p>
        <p>Berikut kami sampaikan server anda telah dilakukan POWER OFF :</p>
        <table>
            <tr>
                <td>Nama Server</td>
                <td>:</td>
                <td>`+ server_name + `</td>
            </tr>
            <tr>
                <td>IP</td>
                <td>:</td>
                <td>`+ ip + `</td>
            </tr>
        </table>

        <p>Apabila Bapak/Ibu akan memperpanjang masa aktif server, mohon dapat menghubungi pengserver.pusintek@kemenkeu.go.id, apabila tidak diperpanjang server akan kami hapus</p>

        <p> Demikian kami sampaikan atas perhatiannya kami ucapkan terima kasih​ .</p>
        `;
        break;
      case 3:
        serverState = stateDelete;
        emailBody = `
        <body>
        <p>Yth. Rekan-rekan Pengelolaan Server ,</p>
        <p>Berikut server yang telah dilakukan POWER OFF dan bisa dilakukan penghapusan dari infrastruktur :</p>
        <table>
            <tr>
                <td>Nama Server</td>
                <td>:</td>
                <td>`+ server_name + `</td>
            </tr>
            <tr>
                <td>IP</td>
                <td>:</td>
                <td>`+ ip + `</td>
            </tr>
        </table>

        <p> Demikian kami sampaikan atas perhatiannya kami ucapkan terima kasih​ .</p>
        `;
        email = 'pengserver.pusintek@kemenkeu.go.id';
        break
      default:
        serverState = emailDefault;
        emailBody = `<p>Default message</p>`;
        break;
    }

    console.log('Server ' + server_name + ' : ' + serverState);

    let htmls = emailBody;

    let mailOptions = {
      from: from_email,
      cc: ccs,
      sender: senders,
      to: email,
      subject: subjects,
      html: htmls,
    };

    console.log('Ready to send email');

    // var sentStatus;
    // let info = await transporter.sendMail(mailOptions, function (error, info) {
    //   if (error) {
    //     console.log('error on sending email');
    //     return 1;
    //   } else return 2;
    // });

    // await console.log(info);
    let resp = await wrapedSendMail(mailOptions);
    // log or process resp;
    // return resp;

    // if (sentStatus == undefined) {
    //   console.log('error on sending email and set status');
    //   break;
    // }

    console.log('sent status (bool) : ' + resp);
    let sentStatus = resp == true ? 1 : 2;
    console.log('sent status : ' + sentStatus);

    let { data, errors } = await sendHasura(HASURA_UPDATE_AFTER_SEND_EMAIL, { '_eq': id_email_schedule, 'status': sentStatus }, { 'content-type': 'application/json' });

    // if Hasura operation errors, then throw error
    if (errors) {
      console.log('error updating data email_schedule to GraphQL after send email')
    } else {
      console.log('data email_schedule successfully updated after send email ');
    }
  }
  console.log('================= end ===============');
});


// Request Handler
app.post('/createEvent', async (req, res) => {

  // get request input
  const { object } = req.body.input;
  const { session_variables } = req.body;

  // run some business logic
  // this is where the validation logic should be placed

  /*
  // check for availability of attendee ids
  const attendees_data = object.attendees.map((attendee, index) => {
    return { user_id: attendee.id };
  });

  // fetch all events of attendees
  const query = `query ($attendees: [Int!]!) {
    event_attendee(where:{user_id: {_in: $attendees}}) {
      id
    }
  }`;
  */

  const finalObject = {
    object: {
      ...object, attendees: { data: [...attendees_data] }
    }
  };

  const headers = { ...session_variables };

  // execute the Hasura operation
  const { data, errors } = await execute(HASURA_OPERATION, finalObject, headers);

  // if Hasura operation errors, then throw error
  if (errors) {
    return res.status(400).json(errors[0])
  }
  // insert successful

  // check if recurring event
  const isRecurring = object.isRecurring;
  const recurrencePattern = object.recurrencePattern;

  // schedule an one-off event
  const schedule_event_obj = {
    "type": "create_scheduled_event",
    "args": {
      "webhook": process.env.SCHEDULE_WEBHOOK_URL,
      "schedule_at": moment.utc(object.start_date_time_utc).subtract('10', 'minutes'),
      "payload": {
        attendees_data
      }
    }
  };
  //
  const scheduleResponse = await fetch(
    process.env.HASURA_GRAPHQL_METADATA_ENDPOINT,
    {
      method: 'POST',
      body: JSON.stringify(schedule_event_obj),
      headers: {
        'x-hasura-admin-secret': process.env.HASURA_GRAPHQL_ADMIN_SECRET,
      }
    }
  );
  const scheduleData = await scheduleResponse.json();
  console.log('DEBUG: ', scheduleData);

  // success
  return res.json({
    ...data.insert_event_one
  })

});

app.listen(PORT);
