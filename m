Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+f4q=8rvxndbJNkp5KNMYRoKHs-zKOL1zwXfS0T2A3mA@mail.gmail.com>
References: <20171204191357.3211-1-atull@kernel.org> <20171204191357.3211-3-atull@kernel.org>
 <CAL_Jsq+f4q=8rvxndbJNkp5KNMYRoKHs-zKOL1zwXfS0T2A3mA@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 4 Dec 2017 14:12:16 -0600
Message-ID: <CANk1AXQ0KuzFucbTQ1LtF8F-XMqTw4y2xmVA-rqHcMAQH7hsnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: dynamic: add overlay-allowed DT property
Content-Type: text/plain; charset="UTF-8"
To: Rob Herring <robh+dt@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Dec 4, 2017 at 2:04 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Mon, Dec 4, 2017 at 1:13 PM, Alan Tull <atull@kernel.org> wrote:
>> Allow DT nodes to be marked as valid targets for DT
>> overlays by the added "overlay-allowed" property.
>
> Why do you need a property for this? I'm not all that keen on putting
> this policy into the DT. It can change over time in the kernel. For
> example, as we define use cases that work, then we can loosen
> restrictions in the kernel.

For FPGA regions, I don't need it.  Yes, if the other patch is
accepted, I'm sure we will hear more from people who will need some
specific loosening.  I was trying to anticipate that, but I don't have
a specific need.

Alan

>
> Rob
