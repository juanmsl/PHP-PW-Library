<nav class="pw-navbar" id="pw-navbar">
    <section class="pw-navbar-content">
        <section class="pw-navbar-header">
            <img src="<?php echo RESOURCES . "images/favicon.png"; ?>" class="pw-navbar-logo"></img>
            <span class="pw-navbar-line"></span>
            <h6 class="pw-navbar-title"><?php echo SITE_NAME; ?></h6>
        </section>
        <ul class="pw-navbar-items">
            <li class="pw-navbar-item <?php echo PAGE_ID == "home" ? "active" : ""; ?>"><a href="<?php echo HOME; ?>">Home</a></li>
            <li class="pw-navbar-item <?php echo PAGE_ID == "rooms" ? "active" : ""; ?>"><a href="<?php echo ROOMS; ?>">Salas</a></li>
            <li class="pw-navbar-item <?php echo PAGE_ID == "events" ? "active" : ""; ?>"><a href="<?php echo EVENTS; ?>">Eventos</a></li>
            <?php if(USER_IS_ADMIN) { ?>
                <li class="pw-navbar-item <?php echo PAGE_ID == "control" ? "active" : ""; ?>"><a href="<?php echo CONTROL; ?>">Control</a></li>
                <li class="pw-navbar-item <?php echo PAGE_ID == "requests" ? "active" : ""; ?>"><a href="<?php echo REQUESTS; ?>">Solicitudes</a></li>
                <li class="pw-navbar-item <?php echo PAGE_ID == "return" ? "active" : ""; ?>"><a href="<?php echo RETURNBOOK; ?>">Devolución</a></li>
            <?php } ?>
            <li class="pw-navbar-item pw-navbar-sign-out"><a href="<?php echo SIGNOUT; ?>" class="pwi pwi-sign-out" title="Cerrar sesión"></a></li>
        </ul>
    </section>
</nav>