Return-Path: <robh+dt@kernel.org>
Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171204191357.3211-3-atull@kernel.org>
References: <20171204191357.3211-1-atull@kernel.org> <20171204191357.3211-3-atull@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 4 Dec 2017 14:04:19 -0600
Message-ID: <CAL_Jsq+f4q=8rvxndbJNkp5KNMYRoKHs-zKOL1zwXfS0T2A3mA@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: dynamic: add overlay-allowed DT property
Content-Type: text/plain; charset="UTF-8"
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Dec 4, 2017 at 1:13 PM, Alan Tull <atull@kernel.org> wrote:
> Allow DT nodes to be marked as valid targets for DT
> overlays by the added "overlay-allowed" property.

Why do you need a property for this? I'm not all that keen on putting
this policy into the DT. It can change over time in the kernel. For
example, as we define use cases that work, then we can loosen
restrictions in the kernel.

Rob
