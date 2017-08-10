Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJoqK9UdDfQGc0ng1C+cYv4BSZfLaxDCJWJRS=pDCQzng@mail.gmail.com>
References: <20170718214339.7774-22-robh@kernel.org> <20170719044221.GA1581@tyrael.ni.corp.natinst.com>
 <CANk1AXSZxj3bb5oXZAyonJ=QgDV3FKuPgSNFDo3m9hzfEtjbbg@mail.gmail.com> <CAL_JsqJoqK9UdDfQGc0ng1C+cYv4BSZfLaxDCJWJRS=pDCQzng@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 10 Aug 2017 09:16:25 -0500
Message-ID: <CANk1AXSBmeJTU9GO+g+GVSWbxD-dSDB5UWpevc4uJ2jueH-jYg@mail.gmail.com>
Subject: Re: [PATCH] fpga: Convert to using %pOF instead of full_name
Content-Type: text/plain; charset="UTF-8"
To: Rob Herring <robh@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Moritz Fischer <moritz.fischer@ettus.com>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

I sent it on 8/2/2017.  I probably missed a window.

Alan

On Wed, Aug 9, 2017 at 4:54 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Jul 19, 2017 at 9:32 AM, Alan Tull <atull@kernel.org> wrote:
>> On Tue, Jul 18, 2017 at 11:42 PM, Moritz Fischer <mdf@kernel.org> wrote:
>>> On Tue, Jul 18, 2017 at 04:43:02PM -0500, Rob Herring wrote:
>>>> Now that we have a custom printf format specifier, convert users of
>>>> full_name to use %pOF instead. This is preparation to remove storing
>>>> of the full path string for each node.
>>>>
>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>> Cc: Alan Tull <atull@kernel.org>
>>>> Cc: Moritz Fischer <moritz.fischer@ettus.com>
>>>> Cc: linux-fpga@vger.kernel.org
>>> Acked-by: Moritz Fischer <mdf@kernel.org>
>>
>> Acked-by: Alan Tull <atull@kernel.org>
>
> This hasn't been applied in -next. Are you going to send to Greg?
>
> Rob
