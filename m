Return-Path: <SRS0=vSF4=YW=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=vSF4=YW=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from smtp3-1.goneo.de ([85.220.129.38]:49373 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfJ2FxX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Oct 2019 01:53:23 -0400
Subject: Re: [PATCH v2] kernel-doc: rename the kernel-doc directive
 'functions' to 'identifiers'
References: <20191020131717.28990-1-changbin.du@gmail.com>
 <20191024121940.1d6a64df@lwn.net> <87woctb9cj.fsf@intel.com>
 <20191025144802.uixg2crhw6h7gghq@mail.google.com> <87v9s99q9l.fsf@intel.com>
 <20191029003120.llve32crfw63ovpw@mail.google.com>
From: Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <36c4dcfb-5425-b4bc-a5e9-4fd1458c8385@darmarit.de>
Date: Tue, 29 Oct 2019 06:42:46 +0100
MIME-Version: 1.0
In-Reply-To: <20191029003120.llve32crfw63ovpw@mail.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Matthew Wilcox <willy@infradead.org>, Thomas Zimmermann <tzimmermann@suse.de>

Am 29.10.19 um 01:31 schrieb Changbin Du:
>> But is it, really? I agree with Jon about the distinction between None
>> and '' being confusing.
>>
> Here python is different from C. Both empty string and None are False in python.
> Note such condition is common in python.

The one is a empty string str(''), its bool('') value is False.

| >>> type(''), bool('')
| (<class 'str'>, False)

The other is a NoneType, its bool(None) value is False.

| >>> type(None), bool(None)
| (<class 'NoneType'>, False)

None often used like NULL (pointer). E.g if a function does not give an explicit 
return value, the returned value is None.

| >>> def foo():
| ...     pass
| ...
| >>> print(foo())
| None


-- Markus --
