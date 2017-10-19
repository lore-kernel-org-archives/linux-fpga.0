Return-Path: <SRS0=RZvw=BS=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=RZvw=BS=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH v2 5/5] of/fdt: only store the device node basename in
 full_name
References: <20170821151651.25096-1-robh@kernel.org>
 <20170821151651.25096-6-robh@kernel.org>
 <CANk1AXTLT9gB_f0GZLODpppjkxqDAp1x1RZmQ8O1i+UHckimxw@mail.gmail.com>
 <CABGGisxU2OPZz-rrWYZYgCQ0iGM9w5vL9Ob9BTHALFN8JyxeJQ@mail.gmail.com>
 <59E69786.2030406@gmail.com>
 <CANk1AXStoiNtJfU0iNug1wKASurqH6OrNoaN=UtSh6xxSB088Q@mail.gmail.com>
 <CAL_JsqKR3Jg+tgZr4xGPtcWnZW7ng741YjuyUFaS2SXKXbxGtg@mail.gmail.com>
 <1508341985.25643.12.camel@hp800z>
 <CAL_JsqKJ74y3qHVqbRph5C8=0Ggb+n=JT3TZybu2+mENyZ1VZA@mail.gmail.com>
 <4393AFA4-620F-4C21-995D-A9806DAE1990@konsulko.com>
 <20171019200615.GA10743@tyrael.ni.corp.natinst.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <59E91D4D.8000200@gmail.com>
Date: Thu, 19 Oct 2017 14:46:53 -0700
MIME-Version: 1.0
In-Reply-To: <20171019200615.GA10743@tyrael.ni.corp.natinst.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Moritz Fischer <mdf@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Rob Herring <robh@kernel.org>, Alan Tull <atull@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@aculab.com>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 10/19/17 13:06, Moritz Fischer wrote:

< snip >

> We also have plenty of code that is just not aware of overlays, and
> assumes certain parts of the tree to stay static.

I would state that somewhat differently.  :-)  There is very little
code that is aware of overlays, and most code assumes the device tree
does not change after early boot.

This is one of the areas where the creation of overlays needs to be
done with care.


> I ran into that issue when I tried to add thermal zones via an overlay,
> I've been investigating how to fix the thermal framework to work with
> overlays since then and have some partially working code.
> Currently the thermal framework parses the thermal-zones node at boot,
> and assumes this stays static. This breaks with overlays.
> 
> I agree we eventually need to fix the parts that break when we use
> overlays.
