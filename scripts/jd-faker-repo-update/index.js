const request = require("axios");
const dayjs = require("dayjs");
const utc = require("dayjs/plugin/utc");
dayjs.extend(utc);

const exec = require("child_process").exec;

request.get("https://api.github.com/repos/shufflewzc/faker2").then((res) => {
  const { updated_at } = res.data;
  // 更新时间在五分钟之内

  console.log("更新时间为" + updated_at);

  if (dayjs.utc(updated_at).diff(dayjs.utc(), "m") > -5) {
    console.log("当前项目代码五分钟之内进行过更新,将触发青龙更新");

    exec(
      'docker exec -i qinglong ql repo https://ghproxy.com/https://github.com/shufflewzc/faker2.git "jd_|jx_|gua_|jddj_|getJDCookie" "activity|backUp" "^jd[^_]|USER|function|utils|ZooFaker_Necklace.js|JDJRValidator_Pure|sign_graphics_validate|ql"',
      function (err, stdout, stderr) {
        if (err) {
          console.error("青龙更新失败\n");
          console.log("err");
        } else {
          console.log("青龙更新成功");
        }
      }
    );
  }
});
