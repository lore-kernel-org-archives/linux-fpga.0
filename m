Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411622E0B71;
	Thu, 19 Feb 2026 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771530084; cv=none; b=hHWYRvDHQdSaAwj6xAoV2u7ENtQ369z71C0MzzHfSo+enJrIIRwc7I5LYRKismmDmChQ5NlNGR0TsnPqcgLSQ0AjQDBDYnJrr4I5MTt71O51jlmMih7opjxVrnnJ7C4cHzp29q/QqY5oF55/iFx1O7PNczQjiHk25OWv/Wp3e8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771530084; c=relaxed/simple;
	bh=X/YpBpZHELPnaJx/3vhuFsswpFYW6glhYMozRGxU4LA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPDbMhDiWeSaAwI/lT/JFPkOBZnylqO/BgEqp6q5xC25iEo40L1pCoHRJ2o/WSfg+pkjrMvBSj6RHlyUkWqsuL7tP0xFaA0Kx+aOulrq7HE7MMSgLOYR0CnDvTL0dnIudcNGrsw83TQVIjK8aHtBaYQunnv8DPQd7v0CqDSg4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkl2KvYU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkl2KvYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2130C4CEF7;
	Thu, 19 Feb 2026 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771530083;
	bh=X/YpBpZHELPnaJx/3vhuFsswpFYW6glhYMozRGxU4LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mkl2KvYUp1F20IHclNSctcmg7lauq73IyKRQVwNswPbGoI6InqBDg3hg3+ZZjrC5+
	 5xmyGuTkpEHJV0pwMOSQD/AGbI7y/Gfu2tlqomWKRqJxzs0k7iyB5FgUZmbvEJN1Jr
	 143Utb+tQnNMyiVaUvN5yMocMVNw6pxSL0gpl782Qnl4kmKLvcRuzlSKeI/6HvCO0O
	 cEdBu7hbLoRa5DdaMkj5qAYzVx+cSc6FNnedSBfqttW3KBbws4+0p75nGaviS2XlKy
	 /DcvgKUxO7GDfsM+RyLVLnUcTPCg3V0w1icecFDyLIzQuKI5jIz6oCCYC+oui9lbvo
	 ctR3U1d0NfrUQ==
Date: Thu, 19 Feb 2026 11:41:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Andrew Morton <akpm@linux-foundation.org>, Antoine Tenart
 <atenart@kernel.org>, Christian Brauner <brauner@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Geetha sowjanya <gakula@marvell.com>, Ingo Molnar <mingo@kernel.org>, James
 Clark <james.clark@linaro.org>, Jerin Jacob <jerinj@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Lukasz Luba <lukasz.luba@arm.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Simon Horman
 <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Subbaraya Sundeep
 <sbhatta@marvell.com>, Sunil Goutham <sgoutham@marvell.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Tom Rix <trix@redhat.com>, Xu Yilun
 <yilun.xu@intel.com>, Yajun Deng <yajun.deng@linux.dev>, Yury Norov
 <yury.norov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, hariprasad
 <hkelam@marvell.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH 00/12] cleanup bitmaps printing in sysfs
Message-ID: <20260219114120.0f4408f7@kernel.org>
In-Reply-To: <20260219181407.290201-1-ynorov@nvidia.com>
References: <20260219181407.290201-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Feb 2026 13:13:52 -0500 Yury Norov wrote:
>  .../marvell/octeontx2/af/rvu_debugfs.c        | 28 +++----------
>  drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   |  6 +--
>  drivers/s390/net/qeth_core_main.c             |  6 +--
>  net/core/net-sysfs.c                          |  2 +-

Please split these changes out and submit them to the correct subsystem
after the merge window. Then push patch 12 during the next merge window.
