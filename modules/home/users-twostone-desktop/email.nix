# SPDX-FileCopyrightText: 2024 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

_: {

  accounts.email.accounts = {
    tcd = {
      flavor = "gmail.com";
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
          "mail.server.server_${id}.authMethod" = 10;
        };
      };
      address = "halbachj@tcd.ie";
      userName = "halbachj@tcd.ie";
      realName = "Johannes Halbach";
      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls = {
          enable = true;
          # useStartTls = true;
        };
      };
      smtp = {
        host = "smtp.gmail.com";
        port = 465;
        tls = {
          enable = true;
          # useStartTls = true;
        };
      };
    };
    halbachnet = {
      primary = true;
      userName = "johannes@halbachnet.de";
      realName = "Johannes Halbach";
      address = "johannes@halbachnet.de";
      flavor = "plain";
      imap.host = "imap.1und1.com";
      imap.port = 993;
      smtp.host = "smtp.1und1.com";
      smtp.port = 465;
    };
  };
  
}
