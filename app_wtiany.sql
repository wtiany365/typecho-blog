-- phpMyAdmin SQL Dump
-- version 3.3.8.1
-- http://www.phpmyadmin.net
--
-- 主机: w.rdc.sae.sina.com.cn:3307
-- 生成日期: 2016 年 04 月 12 日 17:30
-- 服务器版本: 5.6.23
-- PHP 版本: 5.3.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `app_wtiany`
--

-- --------------------------------------------------------

--
-- 表的结构 `typecho_comments`
--

CREATE TABLE IF NOT EXISTS `typecho_comments` (
  `coid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(10) unsigned DEFAULT '0',
  `created` int(10) unsigned DEFAULT '0',
  `author` varchar(200) DEFAULT NULL,
  `authorId` int(10) unsigned DEFAULT '0',
  `ownerId` int(10) unsigned DEFAULT '0',
  `mail` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `agent` varchar(200) DEFAULT NULL,
  `text` text,
  `type` varchar(16) DEFAULT 'comment',
  `status` varchar(16) DEFAULT 'approved',
  `parent` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`coid`),
  KEY `cid` (`cid`),
  KEY `created` (`created`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `typecho_comments`
--


-- --------------------------------------------------------

--
-- 表的结构 `typecho_contents`
--

CREATE TABLE IF NOT EXISTS `typecho_contents` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `created` int(10) unsigned DEFAULT '0',
  `modified` int(10) unsigned DEFAULT '0',
  `text` text,
  `order` int(10) unsigned DEFAULT '0',
  `authorId` int(10) unsigned DEFAULT '0',
  `template` varchar(32) DEFAULT NULL,
  `type` varchar(16) DEFAULT 'post',
  `status` varchar(16) DEFAULT 'publish',
  `password` varchar(32) DEFAULT NULL,
  `commentsNum` int(10) unsigned DEFAULT '0',
  `allowComment` char(1) DEFAULT '0',
  `allowPing` char(1) DEFAULT '0',
  `allowFeed` char(1) DEFAULT '0',
  `parent` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`cid`),
  UNIQUE KEY `slug` (`slug`),
  KEY `created` (`created`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

--
-- 转存表中的数据 `typecho_contents`
--

INSERT INTO `typecho_contents` (`cid`, `title`, `slug`, `created`, `modified`, `text`, `order`, `authorId`, `template`, `type`, `status`, `password`, `commentsNum`, `allowComment`, `allowPing`, `allowFeed`, `parent`) VALUES
(3, 'express4.2使用mongodb存储session', '3', 1404979740, 1405153813, '<!--markdown-->app.js\r\n```javascript\r\nvar session = require(''express-session'');\r\nvar mongoStore = require(''connect-mongo'')(session);\r\napp.use(session({\r\n    secret : config.db.cookieSecret,\r\n    store : new mongoStore({\r\n        db : config.db.database,\r\n        username:config.db.username,\r\n        password:config.db.password,\r\n        url:config.db.mongodb\r\n    })\r\n}));\r\n```', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(4, 'express4.2连接mongodb', '4', 1405153920, 1408348755, '<!--markdown-->config.js\r\n```javascript\r\nmodule.exports = {  \r\n    "db": {  \r\n        "mongodb": "mongodb://test:111111@localhost/microblog",  \r\n        "database": "microblog",  \r\n        "server": "localhost",\r\n        "cookieSecret": "microblog",\r\n        "username" : "test",\r\n        "password" : "111111"  \r\n    }  \r\n};  \r\n```\r\napp.js\r\n```javascript\r\nvar mongoose = require(''mongoose'');\r\nvar config = require(''./config'');\r\nmongoose.connect(config.db.mongodb);\r\nvar db = mongoose.connection;  \r\n//mongdb数据库连接错误的时候被调用  \r\ndb.on(''error'', console.error.bind(console, ''connection error:''));  \r\n//数据库成功打开的时候被调用  \r\ndb.once(''open'', function callback () {  \r\n    console.log(''数据库连接成功!'');  \r\n}); \r\n```\r\n', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(5, 'mongodb权限', '5', 1404871800, 1405321935, '<!--markdown-->mongodb权限需要开启，启动服务时需要加上 -auth参数\r\n```cmd\r\nmongod.exe --dbpath d:/wamp/mongodb/data/db --logpath d:/wam\r\np/mongodb/log/logs -auth\r\n```\r\n\r\n\r\n<!--more-->\r\n\r\n\r\n如果没有-auth参数则不进行权限认证\r\n```cmd\r\n> use admin\r\nswitched to db admin\r\n> show collections\r\nsystem.indexes\r\nsystem.users\r\n> db.system.users.find()\r\n{ "_id" : ObjectId("53bd055d79eb32318a3da8c1"), "user" : "admin", "readOnly" : f\r\nalse, "pwd" : "95ec4261124ba5951720b199908d892b" }\r\n>\r\n```\r\nadmin库下的system.users表存放超级管理员账号 user admin可以访问所有库\r\n```cmd\r\n> use admin\r\nswitched to db admin\r\n> db.auth(''admin'',''123456'')\r\n1       //表示登录成功\r\n> use test\r\nswitched to db test\r\n> show collections\r\nsystem.indexes\r\nsystem.users\r\n```\r\n使用admin账号可以访问test库\r\n\r\n现在给test库单独设立密码\r\n```cmd\r\n> use test\r\n> db.addUser(''test'',''111111'')\r\n{\r\n        "user" : "test",\r\n        "readOnly" : false,\r\n        "pwd" : "2d0c8153e5a91264b6f4d898b8a10e5b",\r\n        "_id" : ObjectId("53bd0a9a4b6fa19cc97fd553")\r\n}\r\n> db.auth(''test'',''111111'')\r\n1\r\n```\r\n\r\n现在可以使用test用户访问test库\r\n\r\n', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(6, 'express安装', '6', 1404259980, 1405322093, '<!--markdown-->```cmd\r\nnpm install -g express\r\nnpm install -g express-generator\r\n```\r\n\r\n\r\n<!--more-->\r\n\r\n\r\n老的express只用安装express就可以执行 新版本需要安装express-generator\r\n```cmd\r\nexpress -e test\r\n```\r\n创建应用程序test -e使用ejs模板 默认jade模板\r\n\r\n然后使用\r\n```cmd\r\ncd test && npm install\r\nnpm start\r\n```\r\n或\r\n```cmd\r\nsupervisor bin/www\r\n```\r\n启动服务器\r\n\r\n', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(7, 'nginx+php', '7', 1404096600, 1405324468, '<!--markdown-->php.ini\r\n```ini\r\ncgi.fix_pathinfo=1\r\n```\r\nnginx.conf\r\n```cnf\r\nlocation ~ \\.php$ {\r\n      root           D:/work;\r\n      fastcgi_pass   127.0.0.1:9000;\r\n      fastcgi_index  index.php;\r\n      fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;\r\n      include        fastcgi_params;\r\n}\r\n```\r\nfastcgi启动\r\n```cmd\r\nphp-cgi.exe -b 127.0.0.1:9000 -c  PATHTO/php.ini\r\n```\r\n', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(8, 'PHP多线程', '8', 1403941920, 1405324343, '<!--markdown-->[扩展下载地址][1]\r\n\r\n\r\n<!--more-->\r\n\r\n\r\n多线程采集\r\n```php\r\nclass test_thread_run extends Thread\r\n  {\r\n      public $url;\r\n      public $data;\r\n  \r\n      public function __construct($url)\r\n      {\r\n          $this->url = $url;\r\n      }\r\n  \r\n      public function run()\r\n      {\r\n          if(($url = $this->url))\r\n          {\r\n              $this->data = model_http_curl_get($url);\r\n          }\r\n      }\r\n  }\r\n  \r\n  function model_thread_result_get($urls_array)\r\n  {\r\n      foreach ($urls_array as $key => $value)\r\n      {\r\n          $thread_array[$key] = new test_thread_run($value["url"]);\r\n          $thread_array[$key]->start();\r\n      }\r\n  \r\n      foreach ($thread_array as $thread_array_key => $thread_array_value)\r\n      {\r\n          while($thread_array[$thread_array_key]->isRunning())\r\n          {\r\n              usleep(10);\r\n          }\r\n          if($thread_array[$thread_array_key]->join())\r\n          {\r\n              $variable_data[$thread_array_key] = $thread_array[$thread_array_key]->data;\r\n          }\r\n      }\r\n      return $variable_data;\r\n  }\r\n  \r\n  function model_http_curl_get($url,$userAgent="")\r\n  {\r\n      $userAgent = $userAgent ? $userAgent : ''Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.2)'';\r\n      $curl = curl_init();\r\n      curl_setopt($curl, CURLOPT_URL, $url);\r\n      curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);\r\n      curl_setopt($curl, CURLOPT_TIMEOUT, 5);\r\n      curl_setopt($curl, CURLOPT_USERAGENT, $userAgent);\r\n      $result = curl_exec($curl);\r\n      curl_close($curl);\r\n      return $result;\r\n  }\r\n  \r\n  for ($i=0; $i < 100; $i++)\r\n  {\r\n      $urls_array[] = array("name" => "baidu", "url" => "http://www.baidu.com/s?wd=".mt_rand(10000,20000));\r\n  }\r\n  \r\n  $t = microtime(true);\r\n  $result = model_thread_result_get($urls_array);\r\n  $e = microtime(true);\r\n  echo "多线程：".($e-$t)."";\r\n  \r\n  $t = microtime(true);\r\n  foreach ($urls_array as $key => $value)\r\n  {\r\n      $result_new[$key] = model_http_curl_get($value["url"]);\r\n  }\r\n  $e = microtime(true);\r\n  echo "For循环：".($e-$t)."";\r\n```\r\n\r\n  [1]: http://windows.php.net/downloads/pecl/releases', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(9, 'Zend Guard加密php文件过期时间', '9', 1405761900, 1405762149, '<!--markdown-->zend guard未破解版加密的文件会在14天后过期，这里记录一个加密后不会过期的方法,针对[Zend Guard 5.5][1]版本。\r\n\r\n\r\n<!--more-->\r\n\r\n步骤：\r\n\r\n1.下载 [zend_guard.zip][2]，解压，得到zend_guard.zl 。\r\n2.由于这个licence的有效期是2010.7.10，所以破解前要先将计算机时间调整到之前的时间，如2009.7.10 。\r\n3.打开Zend Guard ->Help->Register，找到刚才解压出的zend_guard.zl，确定即可。\r\n\r\n计算机时间调到2010.7.10之前再加密，文件不会过期\r\n\r\n\r\n  [1]: http://downloads.zend.com/guard/5.5.0/ZendGuard-5_5_0.exe\r\n  [2]: http://wtiany-wtiany.stor.sinaapp.com/files/zend_guard.zip', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(11, 'php文件操作函数', '11', 1407912480, 1408349029, '<!--markdown-->`html` `js`操作的根目录是文档跟目录（即www目录）\r\n	php操作的是系统根目录    （即/目录）\r\n\r\n\r\n<!--more-->\r\n\r\n\r\n```php\r\n	opendir()//打开目录\r\n	readdir()//读取目录\r\n	closedir()//关闭目录\r\n	file_exists()//判断文件是否存在\r\n	filetype()//文件类型\r\n	filectime()//文件创建时间\r\n	fileatime()//文件修改时间\r\n	filemtime()//文件访问时间\r\n	is_dir()//判断是不是目录\r\n	disk_total_space()//返回磁盘总大小\r\n	disk_free_space()//返回磁盘可用空间  以上两个参数举例："c:"\r\n	filesize()//返回文件大小\r\n	mkdir()//创建目录\r\n	rmdir()//删除目录  只能删除空目录\r\n	unlink()//删除文件\r\n	rename（源文件，目标文件）//移动文件  目录和文件都可以\r\n	copy(源文件，目标文件)//复制文件  只能复制文件\r\n	touch(ge.txt)//创建文件\r\n	file_put_contents()//写文件内容  如果没有可以自动创建 参数可以是url\r\n	file_get_contents()//读文件内容 可以是url\r\n	file()//读文件内容,返回一个数组，数组中没个元素是文件的每一行\r\n	fopen()//打开文件 第二个参数r只读文件指针在文件头 w只写并将文件内容清空 r+可读可写并将文件清空 a写入方式打开，文件指针在最后，通常用于追加文件内容\r\n	fgetc()//一次读一个字符 \r\n	feof()//如果到文件尾 返回真\r\n	fgets()//一次读一行\r\n	fread（文件资源，字节数）//一次读指定个字符\r\n	ftell()//返回指针的位置\r\n	fseek（文件资源，偏移量）//指真偏移指定位数\r\n	rewind()//指针回文件头\r\n```\r\n	追加方式只能在文件尾追加内容', 0, 2, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(13, 'ubuntu源码安装mysql5.6', '13', 1408182780, 1408348646, '<!--markdown-->`ubuntu`发行号`Ubuntu 14.04 LTS \\n \\l` `mysql`版本5.6.19\r\n\r\n\r\n<!--more-->\r\n\r\n\r\n```shell\r\n$ cd /usr/local/src\r\n$ sudo wget http://downloads.mysql.com/archives/get/file/mysql-5.6.19.tar.gz\r\n$ tar -zxvf mysql-5.6.19.tar.gz\r\n$ cd mysql-5.6.19\r\n$ sudo cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1\r\n```\r\n\r\n```shell\r\n-- Could NOT find Curses (missing:  CURSES_LIBRARY CURSES_INCLUDE_PATH)\r\nCMake Error at cmake/readline.cmake:85 (MESSAGE):\r\n  Curses library not found.  Please install appropriate package,\r\n\r\n      remove CMakeCache.txt and rerun cmake.On Debian/Ubuntu, package name is libncurses5-dev, on Redhat and derivates it is ncurses-devel.\r\n```\r\n报错，提示没有`Curses library`\r\n```shell\r\n$ sudo apt-get install libncurses5-dev\r\n$ sudo rm -rf CMakeCache.txt\r\n$ sudo cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1\r\n```\r\n\r\n```shell\r\nCMake Error at /usr/share/cmake-2.8/Modules/CMakeCXXInformation.cmake:37 (get_filename_component):\r\n  get_filename_component called with incorrect number of arguments\r\nCall Stack (most recent call first):\r\n  CMakeLists.txt:3 (PROJECT)\r\n\r\n\r\nCMake Error: CMAKE_CXX_COMPILER not set, after EnableLanguage\r\nCMake Error: Internal CMake error, TryCompile configure of cmake failed\r\n```\r\n报错，google说需要安装`g++`\r\n```shell\r\n$ sudo apt-get install g++\r\n$ sudo rm -rf CMakeCache.txt\r\n$ sudo cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1\r\n```\r\n这次顺利\r\n```shell\r\n$ sudo make install\r\n```\r\n漫长等待\r\n安装完成后\r\n```shell\r\n$ cd /usr/local/mysql/\r\n$ sudo groupadd mysql          //创建mysql用户组\r\n$ sudo useradd -g mysql mysql -s /usr/sbin/nologin        //创建不允许登录的mysql用户归属于mysql组\r\n$ sudo cp support-files/my-default.cnf /usr/local/mysql/my.cnf        //配置文件\r\n$ sudo scripts/mysql_install_db --basedir=/usr/local/mysql --datadir=/data/mysql --user=mysql        //初始化，安装授权表等\r\n$ sudo chown -R mysql:mysql /usr/local/mysql/    //权限\r\n$ sudo chown -R mysql:mysql /data/mysql/\r\n```\r\n编辑`my.cnf`\r\n```shell\r\n$ sudo vim /usr/local/mysql/my.cnf\r\n[mysqld]\r\n basedir = /usr/local/mysql\r\n datadir = /data/mysql\r\n log-error = /data/mysql/error.log\r\n pid-file = /data/mysql/mysql.pid\r\n user = mysql\r\n tmpdir = /tmp\r\n socket = /tmp/mysql.sock\r\n\r\n$ sudo cp support-files/mysql.server /etc/init.d/mysqld    //可以用service mysqld start启动\r\n$ sudo cp bin/mysql /usr/bin/mysql        //可以直接使用mysql链接服务器\r\n$ sudo update-rc.d mysqld defaults        //自动启动mysql\r\n$ sudo service mysqld start                //启动mysql\r\n$ mysql -uroot                            //用root登录 初始无密码\r\n\r\nmysql> grant all on *.* to root@localhost identified by ''123456'';//修改root密码123456\r\n```\r\n\r\n\r\n', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(14, 'mysql主从复制', '14', 1408345740, 1408350061, '<!--markdown-->建立mysql主从复制总结为三个步骤\r\n\r\n 1. 配置主服务器`master`\r\n 2. 配置从服务器`slave`\r\n 3. 将`slave`连接到`master`\r\n\r\n\r\n<!--more-->\r\n\r\n \r\n\r\n - 配置主服务器`master`\r\n\r\n```shell\r\n$ sudo vim /usr/local/mysql/my.cnf\r\n#在my.cnf中增加如下\r\n[mysqld]\r\n log-bin = master-bin                //log-bin文件基本名\r\n log-bin-index = master-bin.index    //log-bin-index 二进制日志索引文件名\r\n server-id = 1                        //服务器id\r\n\r\nsudo service mysqld restart        //重启mysql\r\n```\r\n`slave`要连接到`master`并请求把所有的改动转储给它，需要有一个有复制权限的用户\r\n```mysql\r\nmysql> create user repl_user;        //创建用户\r\nQuery OK, 0 rows affected (0.00 sec)\r\nmysql> grant replication slave on *.* to repl_user identified by ''123456'';    //给用户授权，给予replication slave全新\r\nQuery OK, 0 rows affected (0.00 sec)\r\n```\r\n \r\n\r\n - 配置从服务器`slave`\r\n\r\n```shell\r\n$ sudo vim /usr/local/mysql/my.cnf\r\n#在my.cnf中增加如下\r\n[mysqld]\r\n server-id = 2\r\n relay-log-index = slave-relay-bin.index\r\n relay-log = slave-relay-bin\r\n\r\nsudo service mysqld restart        //重启mysql\r\n```\r\n \r\n\r\n - 将`slave`连接到`master`\r\n在slave上执行\r\n```mysql\r\nmysql> change master to\r\n    -> master_host = ''10.0.9.111'',        --`master`服务器ip\r\n    -> master_port = 3306,                --`master`服务器端口\r\n    -> master_user = ''repl_user'',         --`master`上有 `replication slave`权限的用户\r\n    -> master_password = ''123456'';        --密码\r\nQuery OK, 0 rows affected, 2 warnings (0.06 sec)\r\nmysql> start slave;                        --启动主从\r\nQuery OK, 0 rows affected (0.01 sec)\r\n```\r\n现在在`master`上执行\r\n```mysql\r\nmysql> use test\r\nDatabase changed\r\nmysql> create table t1(\r\n    -> id int\r\n    -> );\r\nQuery OK, 0 rows affected (0.38 sec)\r\nmysql> insert into t1 (id) values (1);\r\nQuery OK, 1 row affected (0.06 sec)\r\n```\r\n然后到`slave`上执行如下\r\n```mysql\r\nmysql> use test\r\nDatabase changed\r\nmysql> show tables;\r\nEmpty set (0.00 sec)\r\n```\r\n发现从服务器的test库里没有表，说明主从配置失败\r\n查看`datadir`下的`error.log`文件发现有这样一句\r\n```\r\n2014-08-18 15:19:24 2342 [ERROR] Slave I/O: Fatal error: The slave I/O thread stops because master and slave have equal MySQL server UUIDs; these UUIDs must be different for replication to work. Error_code: 1593\r\n```\r\n因为两台服务器用的是相同的`uuid`，上网查后发现5.6在datadir目录下有一个`auto.cnf`里面设置了服务器的`uuid`,因为我的两台服务器是用vmware克隆出来的  所以完全一样，修改其中一个然后重启服务器，问题解决。\r\n现在在`slave`上执行如下\r\n```mysql\r\nmysql> use test\r\nDatabase changed\r\nmysql> show tables;\r\n+----------------+\r\n| Tables_in_test |\r\n+----------------+\r\n| t1             |\r\n+----------------+\r\n1 row in set (0.00 sec)\r\n\r\nmysql> select * from t1;\r\n+------+\r\n| id   |\r\n+------+\r\n|    1 |\r\n|    2 |\r\n+------+\r\n2 rows in set (0.03 sec)\r\n```\r\n发现刚才创建的表`t1`和插入的两条记录都已经存在了，说明主从配置成功。\r\n', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(17, '解决国内composer无法安装问题', '17', 1414393560, 1414393600, '<!--markdown-->因为`packagist.org`经常被墙导致`composer`无法安装依赖，可以使用`http://pkg.phpcomposer.com`的镜像。\r\n查看`composer`主目录：通过`composer config -l -g`命令可以列出`composer`的全局配置信息，在这些信息中查找`[home]`配置项就是`composer`的主目录。`Linux`用户请执行`sudo composer config -l -g`命令。\r\n进入 composer 的主目录，打开`config.json`文件（如果没有就自己创建一个），然后增加本镜像服务的配置信息，最终内容如下：\r\n```json\r\n{\r\n            "config": {\r\n\r\n            },\r\n            "repositories": [\r\n                {"type": "composer", "url": "http://pkg.phpcomposer.com/repo/packagist/"},\r\n                {"packagist": false}\r\n            ]\r\n}\r\n```', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(18, 'mysql根据经纬度排序', '18', 1414654860, 1414655029, '<!--markdown-->```php\r\n$lng= 112.466746;\r\n$lat = 34.624828;\r\n$sql = ''select * from table order by ACOS(SIN((''.$lat.'' * 3.1415) / 180 ) *SIN((lat* 3.1415) / 180 ) +COS((''.$lat.'' * 3.1415) / 180 ) * COS((lat* 3.1415) / 180 ) *COS((''.$lng.'' * 3.1415) / 180 - (lng* 3.1415) / 180 ) ) * 6380 asc limit 10''\r\n```\r\n数据库字段`lat`纬度 `lng`经度', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(20, 'php适配器模式', '20', 1418801040, 1418802117, '<!--markdown-->需要转化一个对象的接口用于另一个对象时，实现Adapter对象。\r\n```php\r\n<?php\r\n//源\r\nclass oldObject{\r\n    function method(){\r\n        echo ''method'';\r\n    }\r\n}\r\n//目标\r\ninterface Target{\r\n    function newMethod();\r\n}\r\n//适配器\r\nclass objectAdapter implements Target{\r\n    private $obj;\r\n    function __construct(oldObject $obj){\r\n        $this->obj = $obj;\r\n    }\r\n    function newMethod(){\r\n        return $this->obj->method();\r\n    }\r\n}\r\n$a = new objectAdapter(new oldObject);\r\n$a->newMethod();\r\n\r\n```', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(21, 'php建造者模式', '21', 1421716869, 1421716869, '<!--markdown-->需要创建一个复杂的对象，需要生成的对象属性相互依赖，建造者模式可以强迫生成顺序。\r\n```php\r\nclass DbBuilder{\r\n    private $_db = null;\r\n    private $_config = array();\r\n    function __construct($config){\r\n        $this->_config = $config; \r\n    }\r\n    function build(){\r\n        try{\r\n            $this->_db = new PDO($this->_config[''dsn''],$this->_config[''user''],$this->_config[''password'']);\r\n        }catch(PDOException $e){\r\n            echo ''failed to connect :''.$e->getMessage();\r\n        }\r\n    }\r\n    function getDb(){\r\n        return $this->_db;\r\n    }\r\n}\r\n$builder = new DbBuilder(array(''dsn''=>''mysql:dbname=test;host=127.0.0.1'',''user''=>''root'',''password''=>''123456''));\r\n$builder->build();\r\n$db = $builder->getDb();\r\n```', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(22, 'svn rollback to version', '22', 1444619880, 1444620454, '<!--markdown-->```bash\r\nsvn merge --dry-run -r:73:68 http://my.repository.com/my/project/trunk  //from version 73 to 68,view what the merge will produce\r\nsvn merge -r:73:68 http://my.repository.com/my/project/trunk //merge from 73 to 68\r\nsvn commit -m "Reverted to revision 68." //commit merge\r\n```', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(23, 'php策略模式', '23', 1444620408, 1444620408, '<!--markdown-->```php\r\ninterface method{\r\n    public function doThing();\r\n}\r\nclass methodOne implements method{\r\n    public function doThing(){\r\n        echo ''do something in methodOne''; \r\n    }\r\n}\r\nclass methodTwo implements method{\r\n    public function doThing(){\r\n        echo ''do something in methodTwo''; \r\n    }\r\n}\r\nclass foo{\r\n    private $method;\r\n    public function setMethod(method $method){\r\n        $this->method = $method\r\n    }\r\n    public function doSomething(){\r\n        $this->method->doThing();\r\n    }\r\n}\r\n//use\r\n$foo = new foo();\r\n$foo->setMethod(new methodTwo());\r\n$foo->doSomething();//do something with methodTwo\r\n```\r\n', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(24, '备忘', '24', 1444814820, 1450922769, '<!--markdown-->[php验证类](https://github.com/Wixel/GUMP)\r\n[php验证类](https://github.com/vlucas/valitron)\r\n[一个简单的js模板引擎 artTemplate](https://github.com/aui/artTemplate)\r\n[mysql备份恢复方案](http://blog.csdn.net/mysqldbd/article/details/6138518)\r\n[js生成二维码](https://github.com/jeromeetienne/jquery-qrcode)\r\n[bootstrap后台模板](https://github.com/VinceG/Bootstrap-Admin-Theme)', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(25, 'grunt压缩合并基于requirejs的多页面项目', '25', 1451813400, 1451898243, '<!--markdown-->全局安装grunt-cli\r\n```bash\r\n    npm install -g grunt-cli\r\n```\r\n项目目录创建package.json\r\n```bash\r\n    npm init\r\n```\r\n修改`package.json`\r\n```json\r\n{\r\n  "name": "huiyoucn",\r\n  "version": "0.1.0",\r\n  "devDependencies": {\r\n    "grunt": "~0.4.5",\r\n    "grunt-contrib-jshint": "~0.10.0",\r\n    "grunt-contrib-nodeunit": "~0.4.1",\r\n    "grunt-contrib-uglify": "~0.5.0",\r\n    "grunt-contrib-requirejs":"*"\r\n  }\r\n}\r\n```\r\n\r\n```bash\r\nnpm install\r\n```\r\n创建`Gruntfile.js`\r\n```js\r\nmodule.exports = function(grunt) {\r\n	var matches = grunt.file.expand(''app/**/**.js'');//页面控制文件路径 例如 app/home/index.js\r\n\r\n	var requirejsOptions = {};\r\n	if (matches.length > 0) {\r\n		for (var x = 0; x < matches.length; x++) {\r\n			var path = matches[x];\r\n			grunt.file.write(path.replace(''app'',''source''),grunt.file.read(path).replace(''../../config'',''config''));//先把文件复制到source目录，因为requirejs的config文件会被合并到压缩后的文件中，所以修改config模块路径\r\n			requirejsOptions[''task'' + x] = {\r\n				"options": {//requirejs配置项\r\n					\r\n				    },\r\n				    map:{\r\n				        \r\n				    },\r\n				    shim:{\r\n				        \r\n				    },\r\n					"wrap": true,\r\n					"name": path.replace(''app'',''source''),//需要压缩的文件\r\n					"out": path.replace(''app'',''build''),//输出的文件\r\n					"optimize": "uglify2",//压缩格式\r\n					"uglify2": {\r\n						"mangle": false\r\n					},\r\n					"preserveLicenseComments": false,\r\n					"optimizeAllPluginResources":true,\r\n					"findNestedDependencies":true,//依赖\r\n					"done": function(done, output) {\r\n						done();\r\n					}\r\n				}\r\n			};\r\n		}\r\n	}\r\n\r\n	grunt.initConfig({\r\n		pkg: grunt.file.readJSON(''package.json''),\r\n		requirejs: requirejsOptions\r\n	});\r\n\r\n	grunt.loadNpmTasks(''grunt-contrib-requirejs'');\r\n	grunt.registerTask(''default'', [''requirejs'']);\r\n};\r\n```\r\n', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0),
(26, 'git基本操作', '26', 1453448446, 1453448446, '<!--markdown-->```bash\r\ngit init //初始化\r\ntouch readme.md //创建文件\r\ngit add filename //添加文件\r\ngit commit -m "first commit"//提交\r\ngit checkout -b test//新建test分支\r\ngit checkout master//切换到master分支\r\ngit diff master test//比较不同\r\ngit merge test//合并test分支\r\ngit branch -d test//删除test分支\r\ngit remote add origin http://git.oschina.net//添加远程仓库\r\ngit push origin master//把master 推送到远程仓库\r\ngit pull//从远程库拉取\r\n```\r\n', 0, 1, NULL, 'post', 'publish', NULL, 0, '1', '1', '1', 0);

-- --------------------------------------------------------

--
-- 表的结构 `typecho_fields`
--

CREATE TABLE IF NOT EXISTS `typecho_fields` (
  `cid` int(10) unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `type` varchar(8) DEFAULT 'str',
  `str_value` text,
  `int_value` int(10) DEFAULT '0',
  `float_value` float DEFAULT '0',
  PRIMARY KEY (`cid`,`name`),
  KEY `int_value` (`int_value`),
  KEY `float_value` (`float_value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `typecho_fields`
--


-- --------------------------------------------------------

--
-- 表的结构 `typecho_metas`
--

CREATE TABLE IF NOT EXISTS `typecho_metas` (
  `mid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `type` varchar(32) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `count` int(10) unsigned DEFAULT '0',
  `order` int(10) unsigned DEFAULT '0',
  `parent` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`mid`),
  KEY `slug` (`slug`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- 转存表中的数据 `typecho_metas`
--

INSERT INTO `typecho_metas` (`mid`, `name`, `slug`, `type`, `description`, `count`, `order`, `parent`) VALUES
(4, 'php', 'p', 'category', NULL, 8, 1, 0),
(2, 'nodejs', 'nodejs', 'tag', NULL, 4, 0, 0),
(3, 'mongodb', 'mongodb', 'tag', NULL, 3, 0, 0),
(5, 'mysql', 's', 'category', NULL, 3, 2, 0),
(6, 'javascript', 'j', 'category', NULL, 0, 3, 0),
(7, 'nodejs', 'n', 'category', NULL, 4, 4, 0),
(8, 'mongodb', 'm', 'category', NULL, 1, 5, 0),
(9, 'php', 'php', 'tag', NULL, 8, 0, 0),
(10, 'nginx', 'nginx', 'tag', NULL, 1, 0, 0),
(11, 'mysql', 'mysql', 'tag', NULL, 2, 0, 0),
(12, 'express', 'express', 'tag', NULL, 0, 0, 0),
(13, 'javascript', 'javascript', 'tag', NULL, 0, 0, 0),
(14, 'jquery', 'jquery', 'tag', NULL, 0, 0, 0),
(15, 'css', 'css', 'tag', NULL, 0, 0, 0),
(16, 'zend', 'zend', 'tag', NULL, 1, 0, 0),
(17, 'ubuntu', 'ubuntu', 'tag', NULL, 1, 0, 0),
(18, 'composer', 'composer', 'tag', NULL, 1, 0, 0),
(19, 'svn', 'svn', 'tag', NULL, 1, 0, 0),
(20, 'github', 'github', 'tag', NULL, 1, 0, 0),
(21, 'nodejs requirejs', 'nodejs-requirejs', 'tag', NULL, 0, 0, 0),
(22, 'requirejs', 'requirejs', 'tag', NULL, 1, 0, 0),
(23, 'git', 'git', 'tag', NULL, 1, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `typecho_options`
--

CREATE TABLE IF NOT EXISTS `typecho_options` (
  `name` varchar(32) NOT NULL,
  `user` int(10) unsigned NOT NULL DEFAULT '0',
  `value` text,
  PRIMARY KEY (`name`,`user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `typecho_options`
--

INSERT INTO `typecho_options` (`name`, `user`, `value`) VALUES
('theme', 0, 'default'),
('theme:default', 0, 'a:2:{s:7:"logoUrl";s:0:"";s:12:"sidebarBlock";a:4:{i:0;s:15:"ShowRecentPosts";i:1;s:18:"ShowRecentComments";i:2;s:12:"ShowCategory";i:3;s:11:"ShowArchive";}}'),
('timezone', 0, '28800'),
('charset', 0, 'UTF-8'),
('contentType', 0, 'text/html'),
('gzip', 0, '0'),
('generator', 0, 'Typecho 0.9/13.12.12'),
('title', 0, 'PHP程序员的博客'),
('description', 0, 'PHP程序员的博客'),
('keywords', 0, 'PHP程序员的博客'),
('rewrite', 0, '1'),
('frontPage', 0, 'recent'),
('frontArchive', 0, NULL),
('commentsRequireMail', 0, '1'),
('commentsWhitelist', 0, '0'),
('commentsRequireURL', 0, '0'),
('commentsRequireModeration', 0, '0'),
('plugins', 0, 'a:2:{s:9:"activated";a:2:{s:10:"HelloWorld";a:1:{s:7:"handles";a:1:{s:21:"admin/menu.php:navBar";a:1:{i:0;a:2:{i:0;s:17:"HelloWorld_Plugin";i:1;s:6:"render";}}}}s:9:"TypExport";a:0:{}}s:7:"handles";a:1:{s:21:"admin/menu.php:navBar";a:1:{i:0;a:2:{i:0;s:17:"HelloWorld_Plugin";i:1;s:6:"render";}}}}'),
('commentDateFormat', 0, 'F jS, Y \\a\\t h:i a'),
('siteUrl', 0, 'http://wtiany.sinaapp.com'),
('defaultCategory', 0, '1'),
('allowRegister', 0, '0'),
('defaultAllowComment', 0, '1'),
('defaultAllowPing', 0, '1'),
('defaultAllowFeed', 0, '1'),
('pageSize', 0, '5'),
('postsListSize', 0, '10'),
('commentsListSize', 0, '10'),
('commentsHTMLTagAllowed', 0, NULL),
('postDateFormat', 0, 'Y-m-d'),
('feedFullText', 0, '0'),
('editorSize', 0, '350'),
('autoSave', 0, '0'),
('markdown', 0, '1'),
('commentsMaxNestingLevels', 0, '5'),
('commentsPostTimeout', 0, '2592000'),
('commentsUrlNofollow', 0, '1'),
('commentsShowUrl', 0, '1'),
('commentsMarkdown', 0, '1'),
('commentsPageBreak', 0, '0'),
('commentsThreaded', 0, '1'),
('commentsPageSize', 0, '20'),
('commentsPageDisplay', 0, 'last'),
('commentsOrder', 0, 'DESC'),
('commentsCheckReferer', 0, '1'),
('commentsAutoClose', 0, '0'),
('commentsPostIntervalEnable', 0, '1'),
('commentsPostInterval', 0, '60'),
('commentsShowCommentOnly', 0, '0'),
('commentsAvatar', 0, '1'),
('commentsAvatarRating', 0, 'G'),
('routingTable', 0, 'a:26:{i:0;a:25:{s:5:"index";a:6:{s:3:"url";s:1:"/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:8:"|^[/]?$|";s:6:"format";s:1:"/";s:6:"params";a:0:{}}s:7:"archive";a:6:{s:3:"url";s:6:"/blog/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:13:"|^/blog[/]?$|";s:6:"format";s:6:"/blog/";s:6:"params";a:0:{}}s:2:"do";a:6:{s:3:"url";s:22:"/action/[action:alpha]";s:6:"widget";s:9:"Widget_Do";s:6:"action";s:6:"action";s:4:"regx";s:32:"|^/action/([_0-9a-zA-Z-]+)[/]?$|";s:6:"format";s:10:"/action/%s";s:6:"params";a:1:{i:0;s:6:"action";}}s:4:"post";a:6:{s:3:"url";s:24:"/archives/[cid:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:26:"|^/archives/([0-9]+)[/]?$|";s:6:"format";s:13:"/archives/%s/";s:6:"params";a:1:{i:0;s:3:"cid";}}s:10:"attachment";a:6:{s:3:"url";s:26:"/attachment/[cid:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:28:"|^/attachment/([0-9]+)[/]?$|";s:6:"format";s:15:"/attachment/%s/";s:6:"params";a:1:{i:0;s:3:"cid";}}s:8:"category";a:6:{s:3:"url";s:17:"/category/[slug]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:25:"|^/category/([^/]+)[/]?$|";s:6:"format";s:13:"/category/%s/";s:6:"params";a:1:{i:0;s:4:"slug";}}s:3:"tag";a:6:{s:3:"url";s:12:"/tag/[slug]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:20:"|^/tag/([^/]+)[/]?$|";s:6:"format";s:8:"/tag/%s/";s:6:"params";a:1:{i:0;s:4:"slug";}}s:6:"author";a:6:{s:3:"url";s:22:"/author/[uid:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:24:"|^/author/([0-9]+)[/]?$|";s:6:"format";s:11:"/author/%s/";s:6:"params";a:1:{i:0;s:3:"uid";}}s:6:"search";a:6:{s:3:"url";s:19:"/search/[keywords]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:23:"|^/search/([^/]+)[/]?$|";s:6:"format";s:11:"/search/%s/";s:6:"params";a:1:{i:0;s:8:"keywords";}}s:10:"index_page";a:6:{s:3:"url";s:21:"/page/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:22:"|^/page/([0-9]+)[/]?$|";s:6:"format";s:9:"/page/%s/";s:6:"params";a:1:{i:0;s:4:"page";}}s:12:"archive_page";a:6:{s:3:"url";s:26:"/blog/page/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:27:"|^/blog/page/([0-9]+)[/]?$|";s:6:"format";s:14:"/blog/page/%s/";s:6:"params";a:1:{i:0;s:4:"page";}}s:13:"category_page";a:6:{s:3:"url";s:32:"/category/[slug]/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:34:"|^/category/([^/]+)/([0-9]+)[/]?$|";s:6:"format";s:16:"/category/%s/%s/";s:6:"params";a:2:{i:0;s:4:"slug";i:1;s:4:"page";}}s:8:"tag_page";a:6:{s:3:"url";s:27:"/tag/[slug]/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:29:"|^/tag/([^/]+)/([0-9]+)[/]?$|";s:6:"format";s:11:"/tag/%s/%s/";s:6:"params";a:2:{i:0;s:4:"slug";i:1;s:4:"page";}}s:11:"author_page";a:6:{s:3:"url";s:37:"/author/[uid:digital]/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:33:"|^/author/([0-9]+)/([0-9]+)[/]?$|";s:6:"format";s:14:"/author/%s/%s/";s:6:"params";a:2:{i:0;s:3:"uid";i:1;s:4:"page";}}s:11:"search_page";a:6:{s:3:"url";s:34:"/search/[keywords]/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:32:"|^/search/([^/]+)/([0-9]+)[/]?$|";s:6:"format";s:14:"/search/%s/%s/";s:6:"params";a:2:{i:0;s:8:"keywords";i:1;s:4:"page";}}s:12:"archive_year";a:6:{s:3:"url";s:18:"/[year:digital:4]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:19:"|^/([0-9]{4})[/]?$|";s:6:"format";s:4:"/%s/";s:6:"params";a:1:{i:0;s:4:"year";}}s:13:"archive_month";a:6:{s:3:"url";s:36:"/[year:digital:4]/[month:digital:2]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:30:"|^/([0-9]{4})/([0-9]{2})[/]?$|";s:6:"format";s:7:"/%s/%s/";s:6:"params";a:2:{i:0;s:4:"year";i:1;s:5:"month";}}s:11:"archive_day";a:6:{s:3:"url";s:52:"/[year:digital:4]/[month:digital:2]/[day:digital:2]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:41:"|^/([0-9]{4})/([0-9]{2})/([0-9]{2})[/]?$|";s:6:"format";s:10:"/%s/%s/%s/";s:6:"params";a:3:{i:0;s:4:"year";i:1;s:5:"month";i:2;s:3:"day";}}s:17:"archive_year_page";a:6:{s:3:"url";s:38:"/[year:digital:4]/page/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:33:"|^/([0-9]{4})/page/([0-9]+)[/]?$|";s:6:"format";s:12:"/%s/page/%s/";s:6:"params";a:2:{i:0;s:4:"year";i:1;s:4:"page";}}s:18:"archive_month_page";a:6:{s:3:"url";s:56:"/[year:digital:4]/[month:digital:2]/page/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:44:"|^/([0-9]{4})/([0-9]{2})/page/([0-9]+)[/]?$|";s:6:"format";s:15:"/%s/%s/page/%s/";s:6:"params";a:3:{i:0;s:4:"year";i:1;s:5:"month";i:2;s:4:"page";}}s:16:"archive_day_page";a:6:{s:3:"url";s:72:"/[year:digital:4]/[month:digital:2]/[day:digital:2]/page/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:55:"|^/([0-9]{4})/([0-9]{2})/([0-9]{2})/page/([0-9]+)[/]?$|";s:6:"format";s:18:"/%s/%s/%s/page/%s/";s:6:"params";a:4:{i:0;s:4:"year";i:1;s:5:"month";i:2;s:3:"day";i:3;s:4:"page";}}s:12:"comment_page";a:6:{s:3:"url";s:53:"[permalink:string]/comment-page-[commentPage:digital]";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:36:"|^(.+)/comment\\-page\\-([0-9]+)[/]?$|";s:6:"format";s:18:"%s/comment-page-%s";s:6:"params";a:2:{i:0;s:9:"permalink";i:1;s:11:"commentPage";}}s:4:"feed";a:6:{s:3:"url";s:20:"/feed[feed:string:0]";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:4:"feed";s:4:"regx";s:17:"|^/feed(.*)[/]?$|";s:6:"format";s:7:"/feed%s";s:6:"params";a:1:{i:0;s:4:"feed";}}s:8:"feedback";a:6:{s:3:"url";s:31:"[permalink:string]/[type:alpha]";s:6:"widget";s:15:"Widget_Feedback";s:6:"action";s:6:"action";s:4:"regx";s:29:"|^(.+)/([_0-9a-zA-Z-]+)[/]?$|";s:6:"format";s:5:"%s/%s";s:6:"params";a:2:{i:0;s:9:"permalink";i:1;s:4:"type";}}s:4:"page";a:6:{s:3:"url";s:12:"/[slug].html";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";s:4:"regx";s:22:"|^/([^/]+)\\.html[/]?$|";s:6:"format";s:8:"/%s.html";s:6:"params";a:1:{i:0;s:4:"slug";}}}s:5:"index";a:3:{s:3:"url";s:1:"/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:7:"archive";a:3:{s:3:"url";s:6:"/blog/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:2:"do";a:3:{s:3:"url";s:22:"/action/[action:alpha]";s:6:"widget";s:9:"Widget_Do";s:6:"action";s:6:"action";}s:4:"post";a:3:{s:3:"url";s:24:"/archives/[cid:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:10:"attachment";a:3:{s:3:"url";s:26:"/attachment/[cid:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:8:"category";a:3:{s:3:"url";s:17:"/category/[slug]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:3:"tag";a:3:{s:3:"url";s:12:"/tag/[slug]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:6:"author";a:3:{s:3:"url";s:22:"/author/[uid:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:6:"search";a:3:{s:3:"url";s:19:"/search/[keywords]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:10:"index_page";a:3:{s:3:"url";s:21:"/page/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:12:"archive_page";a:3:{s:3:"url";s:26:"/blog/page/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:13:"category_page";a:3:{s:3:"url";s:32:"/category/[slug]/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:8:"tag_page";a:3:{s:3:"url";s:27:"/tag/[slug]/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:11:"author_page";a:3:{s:3:"url";s:37:"/author/[uid:digital]/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:11:"search_page";a:3:{s:3:"url";s:34:"/search/[keywords]/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:12:"archive_year";a:3:{s:3:"url";s:18:"/[year:digital:4]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:13:"archive_month";a:3:{s:3:"url";s:36:"/[year:digital:4]/[month:digital:2]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:11:"archive_day";a:3:{s:3:"url";s:52:"/[year:digital:4]/[month:digital:2]/[day:digital:2]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:17:"archive_year_page";a:3:{s:3:"url";s:38:"/[year:digital:4]/page/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:18:"archive_month_page";a:3:{s:3:"url";s:56:"/[year:digital:4]/[month:digital:2]/page/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:16:"archive_day_page";a:3:{s:3:"url";s:72:"/[year:digital:4]/[month:digital:2]/[day:digital:2]/page/[page:digital]/";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:12:"comment_page";a:3:{s:3:"url";s:53:"[permalink:string]/comment-page-[commentPage:digital]";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}s:4:"feed";a:3:{s:3:"url";s:20:"/feed[feed:string:0]";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:4:"feed";}s:8:"feedback";a:3:{s:3:"url";s:31:"[permalink:string]/[type:alpha]";s:6:"widget";s:15:"Widget_Feedback";s:6:"action";s:6:"action";}s:4:"page";a:3:{s:3:"url";s:12:"/[slug].html";s:6:"widget";s:14:"Widget_Archive";s:6:"action";s:6:"render";}}'),
('actionTable', 0, 'a:1:{s:9:"typexport";s:16:"TypExport_Action";}'),
('panelTable', 0, 'a:2:{s:5:"child";a:1:{i:1;a:1:{i:0;a:6:{i:0;s:12:"数据导出";i:1;s:12:"数据导出";i:2;s:41:"extending.php?panel=TypExport%2Fpanel.php";i:3;s:13:"administrator";i:4;b:0;i:5;s:0:"";}}}s:4:"file";a:1:{i:0;s:21:"TypExport%2Fpanel.php";}}'),
('attachmentTypes', 0, '@image@'),
('plugin:HelloWorld', 0, 'a:1:{s:4:"word";s:11:"Hello World";}');

-- --------------------------------------------------------

--
-- 表的结构 `typecho_relationships`
--

CREATE TABLE IF NOT EXISTS `typecho_relationships` (
  `cid` int(10) unsigned NOT NULL,
  `mid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cid`,`mid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `typecho_relationships`
--

INSERT INTO `typecho_relationships` (`cid`, `mid`) VALUES
(3, 2),
(3, 3),
(3, 7),
(4, 2),
(4, 3),
(4, 7),
(5, 3),
(5, 8),
(6, 2),
(6, 7),
(7, 4),
(7, 9),
(7, 10),
(8, 4),
(8, 9),
(9, 4),
(9, 9),
(9, 16),
(11, 4),
(11, 9),
(13, 5),
(13, 11),
(13, 17),
(14, 5),
(14, 11),
(17, 4),
(17, 9),
(17, 18),
(18, 5),
(20, 4),
(20, 9),
(21, 4),
(21, 9),
(22, 19),
(23, 4),
(23, 9),
(24, 20),
(25, 2),
(25, 7),
(25, 22),
(26, 23);

-- --------------------------------------------------------

--
-- 表的结构 `typecho_users`
--

CREATE TABLE IF NOT EXISTS `typecho_users` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `mail` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `screenName` varchar(32) DEFAULT NULL,
  `created` int(10) unsigned DEFAULT '0',
  `activated` int(10) unsigned DEFAULT '0',
  `logged` int(10) unsigned DEFAULT '0',
  `group` varchar(16) DEFAULT 'visitor',
  `authCode` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `typecho_users`
--

INSERT INTO `typecho_users` (`uid`, `name`, `password`, `mail`, `url`, `screenName`, `created`, `activated`, `logged`, `group`, `authCode`) VALUES
(1, 'wtiany365@163.com', '$T$tZp0EPjKB700275b94e419c69c0b459534a8e87a4', 'wtiany365@163.com', 'http://wtiany.sinaapp.com', 'wtiany365@163.com', 1405151264, 1453451465, 1451898245, 'administrator', '3fc4ab5552349ab97ac73326c5b22d4c62d2c78a'),
(2, '149656399@qq.com', '$T$bOj6xd0013cfaa17417e7077da40002f142dd5f0e', '149656399@qq.com', NULL, '149656399', 1407899470, 1407913604, 1407899778, 'contributor', '268a32068b08bec4d9e864aaf71b35a6b485886e');
